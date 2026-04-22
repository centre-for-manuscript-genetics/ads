#!/usr/bin/env python3
"""
build_server.py — fast incremental build using persistent Saxon worker processes.

Each worker is a long-running BuildServer JVM instance fed jobs over stdin.
One JVM startup + one stylesheet compilation per worker per build, instead of
one per output file. Expected speedup: 5–10x over build.py.

Usage:
    python build_server.py [options]

Options:
    --workers N         Number of parallel worker processes (default: 5)
    --incremental       Skip files newer than all source XML and stylesheets
    --filter PATTERN    Only build files whose output name contains PATTERN
    --manifest PATH     Manifest file (default: manifest.json)
    --output DIR        Output directory (default: output)
    --saxon JAR         Saxon JAR path (default: build/saxon/saxon-he.jar)
    --xml-dir DIR       XML source directory (default: xml)
    --xsl-dir DIR       Stylesheet directory (default: stylesheets)
    --dry-run           Print jobs without running them
"""

import argparse
import json
import os
import subprocess
import sys
import threading
import time
from collections import deque
from pathlib import Path


# ---------------------------------------------------------------------------
# Configuration — all paths relative to this script's directory (ads/build/)
# ---------------------------------------------------------------------------
BASE_DIR       = Path(__file__).resolve().parent
REPO_DIR       = BASE_DIR.parent
MANIFEST_FILE  = BASE_DIR / "manifest-final.json"
SAXON_DIR      = BASE_DIR / "saxon"
SOURCE_DIR     = REPO_DIR / "source" / "xml"
STYLESHEET_DIR = REPO_DIR / "source" / "stylesheets"
ASSETS_DIR     = REPO_DIR / "assets"
OUTPUT_DIR     = REPO_DIR / "output"
LOG_FILE       = BASE_DIR / "build_server.log"
JAVA_OPTS      = ["-Xmx256m"]

# Default workers — same as build.py
DEFAULT_WORKERS = 10  # i7 6-core: 10 workers; Raspberry Pi 4: use --workers 3


# ---------------------------------------------------------------------------
# Saxon JAR discovery — matches build.py logic
# ---------------------------------------------------------------------------

def get_classpath() -> str:
    """Collect all JARs from saxon/ and saxon/lib/, return as classpath string."""
    jars = list(SAXON_DIR.glob("*.jar"))
    lib_dir = SAXON_DIR / "lib"
    if lib_dir.exists():
        jars += list(lib_dir.glob("*.jar"))
    if not jars:
        print(f"ERROR: no JARs found in {SAXON_DIR}", file=sys.stderr)
        sys.exit(1)
    sep = ";" if os.name == "nt" else ":"
    # Append BASE_DIR (ads/build/) so Java can find BuildServer.class
    return sep.join([str(j) for j in jars] + [str(BASE_DIR)])


# ---------------------------------------------------------------------------
# Freshness check
# ---------------------------------------------------------------------------

def get_source_mtime() -> float:
    """Return the newest mtime across all XML and XSL source files."""
    mtime = 0.0
    for directory in (SOURCE_DIR, STYLESHEET_DIR):
        for f in directory.rglob("*"):
            if f.is_file():
                mtime = max(mtime, f.stat().st_mtime)
    return mtime


def is_stale(output_path: Path, source_mtime: float) -> bool:
    """Return True if output file is missing or older than any source file."""
    if not output_path.exists():
        return True
    return output_path.stat().st_mtime < source_mtime

# ---------------------------------------------------------------------------
# Asset copying
# ---------------------------------------------------------------------------
def copy_assets():
    """Copy images and CSS from assets/ into output/."""
    import shutil
    for subdir in ("images", "css"):
        src = ASSETS_DIR / subdir
        dst = OUTPUT_DIR / subdir
        if not src.exists():
            print(f"WARNING: assets directory not found: {src}", file=sys.stderr)
            continue
        if dst.exists():
            shutil.rmtree(dst)
        shutil.copytree(src, dst)
        print(f"Copied {src} → {dst}")

# ---------------------------------------------------------------------------
# Job formatting
# ---------------------------------------------------------------------------

def format_job(entry: dict) -> str:
    """Format a manifest entry as a tab-separated job line for BuildServer."""
    source_xml  = SOURCE_DIR     / entry["source_xml"].replace("xml/", "", 1)
    stylesheet  = STYLESHEET_DIR / entry["stylesheet"].replace("stylesheets/", "", 1)
    output_file = OUTPUT_DIR     / entry["output_file"]
    parts = [
        f"input={source_xml}",
        f"stylesheet={stylesheet}",
        f"output={output_file}",
    ]
    for k, v in entry.get("params", {}).items():
        parts.append(f"param:{k}={v}")
    return "\t".join(parts)


# ---------------------------------------------------------------------------
# Worker process management
# ---------------------------------------------------------------------------

class Worker:
    """Wraps a single persistent BuildServer subprocess."""

    def __init__(self, worker_id: int, classpath: str):
        self.worker_id = worker_id
        self._lock = threading.Lock()
        self._process = None
        self._classpath = classpath
        self._start()

    def _start(self):
        cmd = ["java"] + JAVA_OPTS + ["-cp", self._classpath, "BuildServer"]
        self._process = subprocess.Popen(
            cmd,
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            bufsize=1,  # line-buffered
        )

    def is_alive(self) -> bool:
        return self._process is not None and self._process.poll() is None

    def restart(self):
        """Restart a dead worker process."""
        if self._process and self._process.poll() is None:
            self._process.kill()
        self._start()

    def run_job(self, job_line: str):
        """
        Send a job line, wait for response.
        Returns (success, message).
        """
        if not self.is_alive():
            self.restart()

        try:
            self._process.stdin.write(job_line + "\n")
            self._process.stdin.flush()
            response = self._process.stdout.readline().strip()
            if response == "done":
                return True, "done"
            elif response.startswith("error:"):
                return False, response[6:].strip()
            else:
                # Unexpected response — treat as error
                return False, f"unexpected response: {response!r}"
        except (BrokenPipeError, OSError) as e:
            return False, f"worker pipe broken: {e}"

    def shutdown(self):
        if self._process and self._process.poll() is None:
            try:
                self._process.stdin.close()
            except OSError:
                pass
            self._process.wait(timeout=5)


# ---------------------------------------------------------------------------
# Build orchestrator
# ---------------------------------------------------------------------------

class BuildOrchestrator:

    def __init__(self, args):
        self.args = args
        self.classpath = get_classpath()
        self.done = 0
        self.skipped = 0
        self.errors = 0
        self.total = 0
        self.error_list = []
        self._print_lock = threading.Lock()
        self._counter_lock = threading.Lock()

    def load_jobs(self):
        if not MANIFEST_FILE.exists():
            print(f"ERROR: manifest not found at {MANIFEST_FILE}", file=sys.stderr)
            sys.exit(1)

        with open(MANIFEST_FILE, encoding="utf-8") as f:
            all_jobs = json.load(f)

        total_all = len(all_jobs)
        filter_pat = self.args.filter_pattern
        if filter_pat:
            all_jobs = [j for j in all_jobs if filter_pat in j["output_file"]]
            print(f"Filter '{filter_pat}': {len(all_jobs)} of {total_all} jobs selected.")

        return all_jobs

    def filter_stale(self, jobs):
        if not self.args.incremental:
            return jobs, 0

        source_mtime = get_source_mtime()
        stale = []
        skipped = 0
        for entry in jobs:
            out = OUTPUT_DIR / entry["output_file"]
            if is_stale(out, source_mtime):
                stale.append(entry)
            else:
                skipped += 1
        return stale, skipped

    def _log(self, msg: str):
        with self._print_lock:
            print(msg, flush=True)

    def _progress(self, success: bool, output_name: str, message: str = ""):
        with self._counter_lock:
            if success:
                self.done += 1
            else:
                self.errors += 1
                self.error_list.append((output_name, message))
            done = self.done
            errors = self.errors
            total = self.total

        i = done + errors
        if success:
            self._log(f"[{i:>6}/{total}] OK    {output_name}")
        else:
            self._log(f"[{i:>6}/{total}] FAIL  {output_name}")
            self._log(f"               {message[:120]}")

    def write_log(self):
        with open(LOG_FILE, "w", encoding="utf-8") as log:
            log.write(f"Build summary: {self.done} succeeded, "
                      f"{self.errors} failed, {self.total} total\n")
            log.write(f"Workers: {self.args.workers}\n")
            if self.args.filter_pattern:
                log.write(f"Filter: {self.args.filter_pattern}\n")
            if self.args.incremental:
                log.write("Mode: incremental\n")
            log.write("\n")
            if self.error_list:
                log.write("Failed jobs:\n")
                for output_name, error in self.error_list:
                    log.write(f"\n  {output_name}\n  {error}\n")
            else:
                log.write("All jobs succeeded.\n")
        print(f"Log written to {LOG_FILE}")

    def run(self):
        all_jobs = self.load_jobs()

        jobs, self.skipped = self.filter_stale(all_jobs)
        self.total = len(jobs)

        if self.args.incremental:
            print(f"Incremental: {self.skipped} jobs skipped, {self.total} to build.")

        if not jobs:
            print("Nothing to build.")
            return

        print(f"Building {self.total} files into {OUTPUT_DIR} "
              f"with {self.args.workers} workers.")
        print()

        if self.args.dry_run:
            for entry in jobs:
                print(format_job(entry))
            return

        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)

        # Start persistent worker processes
        workers = [Worker(i, self.classpath) for i in range(self.args.workers)]

        job_queue = deque(jobs)
        free_workers = deque(workers)
        active = {}   # job_id -> (Worker, entry, Thread)
        results = {}  # job_id -> (success, message, worker, entry)
        results_lock = threading.Lock()

        start_time = time.time()

        def worker_thread(worker, entry, job_id):
            job_line = format_job(entry)
            success, message = worker.run_job(job_line)
            with results_lock:
                results[job_id] = (success, message, worker, entry)

        job_id = 0

        while job_queue or active:
            while job_queue and free_workers:
                worker = free_workers.popleft()
                entry = job_queue.popleft()
                t = threading.Thread(
                    target=worker_thread,
                    args=(worker, entry, job_id),
                    daemon=True
                )
                active[job_id] = (worker, entry, t)
                job_id += 1
                t.start()

            time.sleep(0.05)
            with results_lock:
                finished_ids = list(results.keys())

            for fid in finished_ids:
                with results_lock:
                    success, message, worker, entry = results.pop(fid)
                active.pop(fid, None)
                free_workers.append(worker)
                self._progress(success, entry["output_file"], message)

        for w in workers:
            w.shutdown()

        # Copy assets into output
        if not self.args.dry_run:
            copy_assets()

        elapsed = time.time() - start_time
        rate = self.total / elapsed if elapsed > 0 else 0
        print()
        print(f"Done. {self.done} succeeded, {self.errors} failed "
              f"out of {self.total} total.")
        print(f"({elapsed:.0f}s, {rate:.1f} jobs/sec)")

        self.write_log()

        if self.errors:
            sys.exit(1)


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Build static ADS edition using persistent Saxon workers."
    )
    parser.add_argument(
        "--workers", type=int, default=DEFAULT_WORKERS,
        help=f"Number of parallel worker processes (default: {DEFAULT_WORKERS}). "
             f"Suggested: 10 for i7 6-core, 3 for Raspberry Pi 4."
    )
    parser.add_argument(
        "--incremental", action="store_true",
        help="Skip jobs whose output file is newer than all source XML and stylesheets."
    )
    parser.add_argument(
        "--filter", metavar="PATTERN", dest="filter_pattern", default=None,
        help="Only run jobs whose output filename contains PATTERN "
             "(e.g. --filter zin- to rebuild only sentence pages)."
    )
    parser.add_argument(
        "--dry-run", action="store_true",
        help="Print job lines without running them."
    )
    args = parser.parse_args()

    if not SAXON_DIR.exists():
        print(f"ERROR: Saxon directory not found at {SAXON_DIR}", file=sys.stderr)
        sys.exit(1)

    orchestrator = BuildOrchestrator(args)
    orchestrator.run()


if __name__ == "__main__":
    main()
