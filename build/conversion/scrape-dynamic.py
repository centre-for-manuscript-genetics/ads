#!/usr/bin/env python3
"""
scrape-dynamic.py — crawl the live Cocoon edition from index.html and collect
all reachable internal pages, producing a deduplicated list of every page URL
and its equivalent static filename.

Usage:
    python scrape-dynamic.py [--base-url URL] [--out FILE] [--verbose] [--delay MS]

Options:
    --base-url URL   Base URL of the Cocoon edition (default: http://localhost:8282/ads)
    --out FILE       Output file for reachable page list (default: reachable-dynamic.txt)
    --verbose        Print each page as it is visited
    --delay MS       Delay in milliseconds between requests (default: 50)

Output:
    reachable-dynamic.txt   Sorted list of equivalent static filenames, one per line
    scrape-dynamic.log      Summary and any warnings

The script starts from {base-url}/index.html, parses all <a href="..."> links,
follows internal links only, and recurses. External links, anchors, assets and
mailto links are skipped.

Static filename mapping: the Cocoon URLs use query parameters or path segments
that map to static filenames. The script collects the raw URL paths and derives
the equivalent static filename for each, so the output can be directly compared
with reachable.txt from scrape-manifest.py.
"""

import argparse
import logging
import sys
import time
from collections import deque
from pathlib import Path
from urllib.parse import urljoin, urlparse, urlunparse

try:
    from lxml import etree
except ImportError:
    print("ERROR: lxml is required. Install with: pip install lxml")
    sys.exit(1)

try:
    import urllib.request as urllib_request
    import urllib.error as urllib_error
except ImportError:
    print("ERROR: urllib not available")
    sys.exit(1)


# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

# URL path suffixes to skip (assets)
SKIP_EXTENSIONS = {".css", ".js", ".jpg", ".jpeg", ".png", ".gif", ".svg",
                   ".ico", ".woff", ".woff2", ".ttf", ".eot", ".map"}

# Only follow URLs under this path prefix (set from base_url at runtime)
BASE_PATH = None


# ---------------------------------------------------------------------------
# HTTP fetch
# ---------------------------------------------------------------------------

def fetch_url(url: str, timeout: int = 30) -> bytes:
    """Fetch a URL and return the response bytes, or None on error."""
    try:
        req = urllib_request.Request(
            url,
            headers={"User-Agent": "ads-scraper/1.0"}
        )
        with urllib_request.urlopen(req, timeout=timeout) as resp:
            return resp.read()
    except urllib_error.HTTPError as e:
        logging.warning(f"HTTP {e.code} fetching {url}")
        return None
    except urllib_error.URLError as e:
        logging.warning(f"URL error fetching {url}: {e.reason}")
        return None
    except Exception as e:
        logging.warning(f"Error fetching {url}: {e}")
        return None


# ---------------------------------------------------------------------------
# Parsing
# ---------------------------------------------------------------------------

def extract_links(content: bytes, base_url: str) -> list:
    """Parse HTML content and return all absolute hrefs found."""
    try:
        parser = etree.HTMLParser(recover=True)
        root = etree.fromstring(content, parser)
    except Exception as e:
        logging.warning(f"Cannot parse {base_url}: {e}")
        return []

    hrefs = []
    for el in root.iter():
        href = el.get("href")
        if href:
            # Resolve relative URLs against the current page URL
            absolute = urljoin(base_url, href)
            hrefs.append(absolute)
    return hrefs


def normalise_url(url: str) -> str:
    """
    Normalise a URL for deduplication:
    - Remove fragment
    - Keep query string (Cocoon uses query params for page identity)
    """
    parsed = urlparse(url)
    # Strip fragment only
    normalised = urlunparse((
        parsed.scheme,
        parsed.netloc,
        parsed.path,
        parsed.params,
        parsed.query,
        ""  # no fragment
    ))
    return normalised


def is_internal(url: str, base_url: str) -> bool:
    """Return True if url is under the same host and base path as base_url."""
    parsed_url  = urlparse(url)
    parsed_base = urlparse(base_url)
    if parsed_url.scheme not in ("http", "https"):
        return False
    if parsed_url.netloc != parsed_base.netloc:
        return False
    if not parsed_url.path.startswith(parsed_base.path):
        return False
    return True


def is_asset(url: str) -> bool:
    """Return True if the URL points to a non-page asset."""
    path = urlparse(url).path
    suffix = Path(path).suffix.lower()
    return suffix in SKIP_EXTENSIONS


def url_to_static_filename(url: str, base_url: str) -> str:
    """
    Derive the equivalent static filename from a Cocoon URL.

    Cocoon URLs are of the form:
        http://localhost:8282/ads/AdsM1.html
        http://localhost:8282/ads/apparaat-AdsM1-z001-d0e100.html
        http://localhost:8282/ads/index.html
    etc. — i.e. the static filename is simply the last path segment,
    since the Cocoon sitemap was already rewritten to use static-style URLs.

    If the path ends in / or is empty, map to index.html.
    """
    parsed = urlparse(url)
    path = parsed.path

    # Get the last path segment
    filename = Path(path).name
    if not filename:
        filename = "index.html"

    # Preserve query string if present (some Cocoon URLs may use it)
    # In this edition the sitemap uses path-based routing, so query strings
    # should not appear in page URLs — but include them for safety.
    if parsed.query:
        filename = f"{filename}?{parsed.query}"

    return filename


# ---------------------------------------------------------------------------
# Crawler
# ---------------------------------------------------------------------------

def crawl(base_url: str, start_url: str, delay_ms: int, verbose: bool) -> tuple:
    """
    BFS crawl from start_url, following internal links.
    Returns (visited_urls, static_filenames) as two sets.
    """
    visited   = set()   # normalised URLs
    filenames = set()   # equivalent static filenames
    queue     = deque([normalise_url(start_url)])
    delay_sec = delay_ms / 1000.0

    while queue:
        url = queue.popleft()

        if url in visited:
            continue

        if is_asset(url):
            continue

        if not is_internal(url, base_url):
            continue

        visited.add(url)
        filename = url_to_static_filename(url, base_url)
        filenames.add(filename)

        if verbose:
            print(f"  visiting: {filename}", flush=True)

        content = fetch_url(url)
        if content is None:
            logging.warning(f"Could not fetch (linked but unreachable): {filename}")
            continue

        if delay_sec > 0:
            time.sleep(delay_sec)

        links = extract_links(content, url)
        for link in links:
            norm = normalise_url(link)
            if norm not in visited and is_internal(norm, base_url) and not is_asset(norm):
                queue.append(norm)

    return visited, filenames


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Crawl live Cocoon edition and list all reachable pages as static filenames."
    )
    parser.add_argument(
        "--base-url", default="http://localhost:8282/ads",
        help="Base URL of the Cocoon edition (default: http://localhost:8282/ads)"
    )
    parser.add_argument(
        "--out", default="reachable-dynamic.txt",
        help="Output file (default: reachable-dynamic.txt)"
    )
    parser.add_argument(
        "--verbose", action="store_true",
        help="Print each page as it is visited"
    )
    parser.add_argument(
        "--delay", type=int, default=50,
        help="Delay in milliseconds between requests (default: 50)"
    )
    args = parser.parse_args()

    # Normalise base URL — strip trailing slash
    base_url  = args.base_url.rstrip("/")
    start_url = f"{base_url}/index.html"
    out_file  = Path(args.out)
    log_file  = Path("scrape-dynamic.log")

    logging.basicConfig(
        level=logging.INFO,
        format="%(levelname)s: %(message)s",
        handlers=[
            logging.FileHandler(log_file, encoding="utf-8"),
            logging.StreamHandler(sys.stdout),
        ]
    )

    logging.info(f"Base URL:   {base_url}")
    logging.info(f"Start URL:  {start_url}")
    logging.info(f"Delay:      {args.delay}ms between requests")

    # Quick connectivity check
    logging.info("Checking connectivity...")
    test = fetch_url(start_url)
    if test is None:
        logging.error(f"Cannot reach {start_url} — is Cocoon running?")
        sys.exit(1)
    logging.info("Connected. Starting crawl...")

    visited, filenames = crawl(base_url, start_url, args.delay, args.verbose)

    names = sorted(filenames)
    out_file.write_text("\n".join(names) + "\n", encoding="utf-8")

    logging.info(f"Reachable pages: {len(filenames)}")
    logging.info(f"Written to:      {out_file}")
    logging.info(f"Log:             {log_file}")

    print(f"\nDone. {len(filenames)} reachable pages written to {out_file}")


if __name__ == "__main__":
    main()
