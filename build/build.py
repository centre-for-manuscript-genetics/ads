from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from concurrent.futures import ProcessPoolExecutor, as_completed
from pathlib import Path
from typing import List


# ----------------------------
# Configuration
# ----------------------------
# All paths relative to this script's directory (ads/build/)
BASE_DIR       = Path(__file__).resolve().parent
REPO_DIR       = BASE_DIR.parent
MANIFEST_FILE  = BASE_DIR / "manifest-final.json"
SAXON_DIR      = BASE_DIR / "saxon"
SOURCE_DIR     = REPO_DIR / "source" / "xml"
STYLESHEET_DIR = REPO_DIR / "source" / "stylesheets"
OUTPUT_DIR     = REPO_DIR / "output"
LOG_FILE       = BASE_DIR / "build.log"

# Default workers: conservative defaults per platform.
# Override with --workers on the command line.
DEFAULT_WORKERS = 10  # i7 6-core: 10 workers, leaving 2 threads free
                      # Raspberry Pi 4: use --workers 3


# ----------------------------
# Saxon invocation
# ----------------------------

def run_saxon(job: dict) -> tuple[bool, str]:
    """
    Invoke Saxon-HE for a single build job.
    Returns (success, error_message).

    Saxon CLI syntax:
        java -cp <classpath> net.sf.saxon.Transform -s:source.xml -xsl:stylesheet.xsl -o:output.html param=value ...
    """
    source_xml  = SOURCE_DIR     / job["source_xml"].replace("xml/", "", 1)
    stylesheet  = STYLESHEET_DIR / job["stylesheet"].replace("stylesheets/", "", 1)
    output_file = OUTPUT_DIR     / job["output_file"]

    output_file.parent.mkdir(parents=True, exist_ok=True)

    # Collect all JARs from saxon/ and saxon/lib/
    saxon_jars = list(SAXON_DIR.glob("*.jar")) + list((SAXON_DIR / "lib").glob("*.jar"))
    sep = ";" if os.name == "nt" else ":"
    classpath = sep.join(str(j) for j in saxon_jars)

    cmd = [
        "java", "-Xmx256m", "-cp", classpath,
        "net.sf.saxon.Transform",
        f"-s:{source_xml}",
        f"-xsl:{stylesheet}",
        f"-o:{output_file}",
    ]

    for key, value in job["params"].items():
        cmd.append(f"{key}={value}")

    try:
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=60,
        )
        if result.returncode != 0:
            detail = (result.stderr or result.stdout).strip()
            return False, detail
        return True, ""
    except subprocess.TimeoutExpired:
        return False, "Timed out after 60 seconds"
    except FileNotFoundError:
        return False, "java not found — is the JRE installed and on PATH?"


# ----------------------------
# Main
# ----------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Build static ADS edition from manifest.json using Saxon-HE."
    )
    parser.add_argument(
        "--workers", type=int, default=DEFAULT_WORKERS,
        help=f"Number of parallel Saxon workers (default: {DEFAULT_WORKERS}). "
             f"Suggested: 10 for i7 6-core, 3 for Raspberry Pi 4."
    )
    parser.add_argument(
        "--incremental", action="store_true",
        help="Skip jobs whose output file is newer than the source XML."
    )
    parser.add_argument(
        "--filter", metavar="PATTERN", dest="filter_pattern", default=None,
        help="Only run jobs whose output filename contains PATTERN "
             "(e.g. --filter zin- to rebuild only sentence pages)."
    )
    args = parser.parse_args()

    if not MANIFEST_FILE.exists():
        print(f"ERROR: manifest not found at {MANIFEST_FILE}", file=sys.stderr)
        sys.exit(1)

    if not SAXON_DIR.exists():
        print(f"ERROR: Saxon directory not found at {SAXON_DIR}", file=sys.stderr)
        sys.exit(1)

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

    with MANIFEST_FILE.open(encoding="utf-8") as f:
        all_jobs: List[dict] = json.load(f)

    # Apply filter
    if args.filter_pattern:
        jobs = [j for j in all_jobs if args.filter_pattern in j["output_file"]]
        print(f"Filter '{args.filter_pattern}': {len(jobs)} of {len(all_jobs)} jobs selected.")
    else:
        jobs = all_jobs

    # Apply incremental skip
    if args.incremental:
        def is_stale(job: dict) -> bool:
            output_path = OUTPUT_DIR / job["output_file"]
            if not output_path.exists():
                return True
            source_path = SOURCE_DIR / job["source_xml"].replace("xml/", "", 1)
            return source_path.stat().st_mtime > output_path.stat().st_mtime
        before = len(jobs)
        jobs = [j for j in jobs if is_stale(j)]
        print(f"Incremental: {before - len(jobs)} jobs skipped, {len(jobs)} to build.")

    total   = len(jobs)
    success = 0
    failed  = 0
    errors  = []

    print(f"Building {total} files into {OUTPUT_DIR} with {args.workers} workers.")
    print()

    with ProcessPoolExecutor(max_workers=args.workers) as executor:
        futures = {executor.submit(run_saxon, job): job["output_file"] for job in jobs}
        for i, future in enumerate(as_completed(futures), 1):
            output_file = futures[future]
            ok, error = future.result()

            if ok:
                success += 1
                print(f"[{i:>6}/{total}] OK    {output_file}")
            else:
                failed += 1
                errors.append((output_file, error))
                print(f"[{i:>6}/{total}] FAIL  {output_file}")
                print(f"               {error[:120]}")

    # Summary
    print()
    print(f"Done. {success} succeeded, {failed} failed out of {total} total.")

    # Write log
    with LOG_FILE.open("w", encoding="utf-8") as log:
        log.write(f"Build summary: {success} succeeded, {failed} failed, {total} total\n")
        log.write(f"Workers: {args.workers}\n")
        if args.filter_pattern:
            log.write(f"Filter: {args.filter_pattern}\n")
        if args.incremental:
            log.write("Mode: incremental\n")
        log.write("\n")
        if errors:
            log.write("Failed jobs:\n")
            for output_file, error in errors:
                log.write(f"\n  {output_file}\n")
                log.write(f"  {error}\n")
        else:
            log.write("All jobs succeeded.\n")

    print(f"Log written to {LOG_FILE}")

    if failed:
        sys.exit(1)


if __name__ == "__main__":
    main()
