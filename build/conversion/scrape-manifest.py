#!/usr/bin/env python3
"""
scrape-manifest.py — crawl the static edition from index.html and collect
all reachable internal links, producing a deduplicated list of every HTML
and XML page that can be reached by clicking through the edition.

Usage:
    python scrape-manifest.py [--output-dir DIR] [--out FILE] [--verbose]

Options:
    --output-dir DIR   Directory containing the built HTML files (default: output)
    --out FILE         Output file for the reachable page list (default: reachable.txt)
    --verbose          Print each page as it is visited

Output:
    reachable.txt      Sorted list of all reachable output filenames, one per line
    scrape.log         Summary log

The script starts from index.html, parses all <a href="..."> links, follows
internal relative links (HTML and XML files only), and recurses. It does not
follow external links, mailto links, anchor-only links, or asset links
(CSS, images, JS).

Run from ads-build/ or any directory — paths are resolved relative to
--output-dir.
"""

import argparse
import logging
import sys
from collections import deque
from pathlib import Path
from urllib.parse import urlparse

from lxml import etree


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# File extensions to follow as pages
PAGE_EXTENSIONS = {".html", ".xml"}

# File extensions to skip (assets)
SKIP_EXTENSIONS = {".css", ".js", ".jpg", ".jpeg", ".png", ".gif", ".svg",
                   ".ico", ".woff", ".woff2", ".ttf", ".eot"}


# ---------------------------------------------------------------------------
# Parser
# ---------------------------------------------------------------------------

def make_parser() -> etree.HTMLParser:
    return etree.HTMLParser(recover=True)


def extract_links(file_path: Path) -> list:
    """Parse an HTML or XML file and return all href values found."""
    try:
        content = file_path.read_bytes()
    except OSError as e:
        logging.warning(f"Cannot read {file_path}: {e}")
        return []

    try:
        if file_path.suffix.lower() == ".xml":
            # For XML files, use the XML parser
            parser = etree.XMLParser(recover=True, resolve_entities=False)
            root = etree.fromstring(content, parser)
        else:
            parser = make_parser()
            root = etree.fromstring(content, parser)
    except Exception as e:
        logging.warning(f"Cannot parse {file_path}: {e}")
        return []

    hrefs = []
    # Find all elements with href attribute (covers <a>, <link>, etc.)
    for el in root.iter():
        href = el.get("href")
        if href:
            hrefs.append(href)
    return hrefs


def resolve_link(href: str, current_file: Path, output_dir: Path):
    """
    Resolve an href relative to current_file within output_dir.
    Returns the resolved Path if it is a valid internal page link,
    or None if it should be skipped.
    """
    if not href:
        return None

    # Skip external links, mailto, javascript
    parsed = urlparse(href)
    if parsed.scheme in ("http", "https", "mailto", "javascript"):
        return None

    # Strip fragment
    path_part = parsed.path
    if not path_part:
        return None  # anchor-only link

    # Skip assets
    suffix = Path(path_part).suffix.lower()
    if suffix in SKIP_EXTENSIONS:
        return None
    if suffix not in PAGE_EXTENSIONS:
        return None

    # Resolve relative to current file's directory
    resolved = (current_file.parent / path_part).resolve()

    # Must be inside output_dir
    try:
        resolved.relative_to(output_dir.resolve())
    except ValueError:
        return None

    return resolved


# ---------------------------------------------------------------------------
# Crawler
# ---------------------------------------------------------------------------

def crawl(output_dir: Path, start_file: Path, verbose: bool) -> set:
    """
    BFS crawl from start_file, following internal page links.
    Returns a set of Path objects for all reachable files.
    """
    visited = set()
    queue = deque([start_file.resolve()])

    while queue:
        current = queue.popleft()

        if current in visited:
            continue
        if not current.exists():
            logging.warning(f"File not found (linked but missing): {current.name}")
            continue

        visited.add(current)

        if verbose:
            print(f"  visiting: {current.name}", flush=True)

        hrefs = extract_links(current)
        for href in hrefs:
            resolved = resolve_link(href, current, output_dir)
            if resolved is None:
                continue
            if resolved not in visited:
                queue.append(resolved)

    return visited


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Crawl static edition from index.html and list all reachable pages."
    )
    parser.add_argument(
        "--output-dir", default="output",
        help="Directory containing the built HTML files (default: output)"
    )
    parser.add_argument(
        "--out", default="reachable.txt",
        help="Output file listing reachable pages (default: reachable.txt)"
    )
    parser.add_argument(
        "--verbose", action="store_true",
        help="Print each page as it is visited"
    )
    args = parser.parse_args()

    output_dir = Path(args.output_dir).resolve()
    start_file = output_dir / "index.html"
    out_file   = Path(args.out)
    log_file   = Path("scrape.log")

    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s: %(message)s",
        handlers=[
            logging.FileHandler(log_file, encoding="utf-8"),
            logging.StreamHandler(sys.stdout),
        ]
    )

    if not output_dir.exists():
        logging.error(f"Output directory not found: {output_dir}")
        sys.exit(1)
    if not start_file.exists():
        logging.error(f"Start file not found: {start_file}")
        sys.exit(1)

    logging.info(f"Crawling from: {start_file}")
    logging.info(f"Output dir:    {output_dir}")

    reachable = crawl(output_dir, start_file, args.verbose)

    # Write sorted list of filenames (relative to output_dir)
    names = sorted(p.name for p in reachable)
    out_file.write_text("\n".join(names) + "\n", encoding="utf-8")

    logging.info(f"Reachable pages: {len(reachable)}")
    logging.info(f"Written to:      {out_file}")
    logging.info(f"Log written to:  {log_file}")

    print(f"\nDone. {len(reachable)} reachable pages written to {out_file}")


if __name__ == "__main__":
    main()
