from __future__ import annotations

import argparse
import json
import sys
from collections import defaultdict
from pathlib import Path

from lxml import etree

# ----------------------------
# Usage
# ----------------------------
#
# Run from the ads-build/ directory:
#
#   python validate-links.py
#       Validate all .html and .xml files in output/ against manifest.json.
#
#   python validate-links.py --filter PATTERN
#       Only validate files whose filename contains PATTERN.
#       Examples:
#         python validate-links.py --filter "AdsM1"
#         python validate-links.py --filter "apparaat"
#         python validate-links.py --filter "zin-"
#
# Results are printed to the console (summary) and written in full to
# validate.log in the ads-build/ directory.
# Exit code 0 = all links valid. Exit code 1 = broken links or parse errors.

# ----------------------------
# Configuration
# ----------------------------

BASE_DIR      = Path(__file__).resolve().parent
MANIFEST_FILE = BASE_DIR / "manifest.json"
OUTPUT_DIR    = BASE_DIR / "output"
LOG_FILE      = BASE_DIR / "validate.log"


# ----------------------------
# Helpers
# ----------------------------

def load_valid_filenames(manifest_file: Path) -> set[str]:
    with manifest_file.open(encoding="utf-8") as f:
        jobs = json.load(f)
    return {job["output_file"] for job in jobs}


def is_local_link(href: str) -> bool:
    """
    Returns True if href is a local file link that should be validated.
    Excludes: http(s), mailto, javascript, bare anchors, empty strings,
    and non-HTML/XML resources (css, js, images, fonts, etc.).
    """
    if not href:
        return False
    href = href.strip()
    if href.startswith(("http://", "https://", "mailto:", "javascript:", "#")):
        return False
    # Exclude non-HTML/XML resources — these are assets, not edition pages
    non_page_extensions = (
        ".css", ".js", ".jpg", ".jpeg", ".png", ".gif", ".svg",
        ".ico", ".woff", ".woff2", ".ttf", ".eot", ".pdf",
    )
    # Strip fragment before checking extension
    path = href.split("#")[0]
    if any(path.lower().endswith(ext) for ext in non_page_extensions):
        return False
    return True


def extract_href_target(href: str) -> str:
    """
    Strip fragment from href to get the filename.
    e.g. "AdsM1.html#z006" -> "AdsM1.html"
    """
    return href.split("#")[0].strip()


def extract_links(html_file: Path) -> list[str]:
    """
    Parse an HTML or XML file and return all local href values.
    Uses lxml with recover=True to handle imperfect HTML.
    """
    try:
        parser = etree.HTMLParser(recover=True)
        tree = etree.parse(str(html_file), parser)
        hrefs = tree.xpath("//@href")
        return [h for h in hrefs if is_local_link(h)]
    except Exception as e:
        return [f"__PARSE_ERROR__: {e}"]


# ----------------------------
# Main
# ----------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="Validate internal links in output/ against manifest.json."
    )
    parser.add_argument(
        "--filter", metavar="PATTERN", dest="filter_pattern", default=None,
        help="Only validate files whose filename contains PATTERN."
    )
    args = parser.parse_args()

    if not MANIFEST_FILE.exists():
        print(f"ERROR: manifest not found at {MANIFEST_FILE}", file=sys.stderr)
        sys.exit(1)

    if not OUTPUT_DIR.exists():
        print(f"ERROR: output directory not found at {OUTPUT_DIR}", file=sys.stderr)
        sys.exit(1)

    valid_filenames = load_valid_filenames(MANIFEST_FILE)
    print(f"Loaded {len(valid_filenames)} valid filenames from manifest.")

    # Collect files to validate
    all_files = sorted(OUTPUT_DIR.glob("*.html")) + sorted(OUTPUT_DIR.glob("*.xml"))
    if args.filter_pattern:
        all_files = [f for f in all_files if args.filter_pattern in f.name]
        print(f"Filter '{args.filter_pattern}': {len(all_files)} files selected.")
    else:
        print(f"Validating {len(all_files)} files in {OUTPUT_DIR}.")
    print()

    # Track results
    broken: dict[str, list[str]] = defaultdict(list)  # source file -> list of broken hrefs
    parse_errors: list[str] = []
    total_links = 0
    total_broken = 0

    for i, html_file in enumerate(all_files, 1):
        if i % 1000 == 0:
            print(f"  Progress: {i}/{len(all_files)} files checked...")

        links = extract_links(html_file)

        for href in links:
            if href.startswith("__PARSE_ERROR__"):
                parse_errors.append(f"{html_file.name}: {href}")
                continue

            total_links += 1
            target = extract_href_target(href)

            if not target:
                continue  # bare fragment, skip

            if target not in valid_filenames:
                broken[html_file.name].append(target)
                total_broken += 1

    # Console summary
    print()
    print(f"Validation complete.")
    print(f"  Files checked  : {len(all_files)}")
    print(f"  Links checked  : {total_links}")
    print(f"  Broken links   : {total_broken}")
    print(f"  Files with broken links: {len(broken)}")
    if parse_errors:
        print(f"  Parse errors   : {len(parse_errors)}")
    print()

    if total_broken == 0 and not parse_errors:
        print("All links are valid.")
    else:
        print(f"See {LOG_FILE} for full detail.")

    # Write log
    with LOG_FILE.open("w", encoding="utf-8") as log:
        log.write("VALIDATION SUMMARY\n")
        log.write("==================\n")
        log.write(f"Files checked          : {len(all_files)}\n")
        log.write(f"Links checked          : {total_links}\n")
        log.write(f"Broken links           : {total_broken}\n")
        log.write(f"Files with broken links: {len(broken)}\n")
        if args.filter_pattern:
            log.write(f"Filter                 : {args.filter_pattern}\n")
        log.write("\n")

        if parse_errors:
            log.write("PARSE ERRORS\n")
            log.write("------------\n")
            for err in parse_errors:
                log.write(f"  {err}\n")
            log.write("\n")

        if broken:
            log.write("BROKEN LINKS\n")
            log.write("------------\n")
            for source_file, targets in sorted(broken.items()):
                log.write(f"\n  {source_file}\n")
                # Dedupe targets but preserve first-seen order
                seen = set()
                for target in targets:
                    if target not in seen:
                        seen.add(target)
                        log.write(f"    -> {target}\n")
        else:
            log.write("No broken links found.\n")

    print(f"Log written to {LOG_FILE}")

    if total_broken or parse_errors:
        sys.exit(1)


if __name__ == "__main__":
    main()
