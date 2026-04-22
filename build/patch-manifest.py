#!/usr/bin/env python3
"""
patch-manifest.py — add missing pages to manifest-final.json.

Handles two categories:
1. Missing apparatus pages (apparaat_comp1_comp2-seg_base-app_n.html)
   parsed directly from the missing filenames in filter.log
2. AdsM1 iframe pages (AdsM1-{page}-iframe.html)
   hardcoded list of pages required by popup views but invisible to the scraper

Usage:
    python patch-manifest.py [options]

Options:
    --manifest FILE   Input manifest to patch (default: manifest-final.json)
    --missing FILE    Missing files list, one filename per line (default: missing.txt)
    --out FILE        Output manifest (default: manifest-final.json, overwrites input)
    --source-xml STR  Source XML for Ads apparatus (default: xml/ads.xml)
    --opd-xml STR     Source XML for Opd apparatus (default: xml/opd.xml)
    --stylesheet STR  Stylesheet for apparatus (default: stylesheets/ads.xsl)

Prepare missing.txt by running:
    grep "^  [a-zA-Z]" filter.log | grep "^  apparaat_" | sed 's/^  //' > missing.txt
"""

import argparse
import json
import re
import sys
from pathlib import Path


# ---------------------------------------------------------------------------
# Hardcoded missing comparison pages — b-witnesses vs their own Z-base.
# These are not apparatus pages and not reachable via the scraper's
# apparatus grep, so they are added explicitly here.
# ---------------------------------------------------------------------------

MISSING_COMPARISON_PAGES = [
    {"output_file": "AdsM3b-varianten-AdsZM3.html",
     "source_xml": "xml/ads.xml", "stylesheet": "stylesheets/ads.xsl",
     "params": {"document": "AdsM3b", "comp1": "AdsM3b", "comp2": "AdsZM3",
                "page": "1", "text": "doclin", "trans": "yes"}},
    {"output_file": "AdsP1b-varianten-AdsZP1.html",
     "source_xml": "xml/ads.xml", "stylesheet": "stylesheets/ads.xsl",
     "params": {"document": "AdsP1b", "comp1": "AdsP1b", "comp2": "AdsZP1",
                "page": "1", "text": "doclin", "trans": "yes"}},
    {"output_file": "OpdP1b-varianten-OpdZP1.html",
     "source_xml": "xml/opd.xml", "stylesheet": "stylesheets/ads.xsl",
     "params": {"document": "OpdP1b", "comp1": "OpdP1b", "comp2": "OpdZP1",
                "page": "1", "text": "doclin", "trans": "yes"}},
]



IFRAME_PAGES = [
    "AdsM1-1-iframe.html",
    "AdsM1-2-iframe.html",
    "AdsM1-3-iframe.html",
    "AdsM1-3A-iframe.html",
    "AdsM1-4-iframe.html",
    "AdsM1-5-iframe.html",
    "AdsM1-6-iframe.html",
    "AdsM1-6A-iframe.html",
    "AdsM1-7-iframe.html",
    "AdsM1-8-iframe.html",
    "AdsM1-9-iframe.html",
    "AdsM1-10-iframe.html",
    "AdsM1-11-iframe.html",
    "AdsM1-12-iframe.html",
    "AdsM1-13-iframe.html",
    "AdsM1-14-iframe.html",
    "AdsM1-15-iframe.html",
    "AdsM1-16-iframe.html",
    "AdsM1-17-iframe.html",
    "AdsM1-18-iframe.html",
]


# ---------------------------------------------------------------------------
# Filename parsers
# ---------------------------------------------------------------------------

def parse_apparatus_filename(filename: str):
    """
    Parse a two-witness apparatus filename into its components.
    Pattern: apparaat_{comp1}_{comp2}-{seg_base}-{app_n}.html
    seg_base may be empty (double-dash: apparaat_{comp1}_{comp2}--{app_n}.html)
    Returns dict with keys: comp1, comp2, seg_base, app_n
    or None if the filename doesn't match.
    """
    # Strip .html
    name = filename
    if name.endswith(".html"):
        name = name[:-5]

    # Must start with apparaat_
    if not name.startswith("apparaat_"):
        return None

    # Remove prefix
    name = name[len("apparaat_"):]

    # Split on first underscore to get comp1, then remainder
    # comp1 is e.g. AdsM2b, AdsP1a, OpdP1b etc.
    # remainder is comp2-seg_base-app_n
    underscore = name.find("_")
    if underscore < 0:
        return None
    comp1 = name[:underscore]
    remainder = name[underscore + 1:]

    # Find comp2: everything up to the first hyphen followed by z or f or other seg_base pattern
    # comp2 can contain letters and digits (e.g. AdsZM2, AdsD6, OpdP1b)
    # seg_base starts with a hyphen then is either empty or starts with z/f/xyz etc.
    # app_n is the last hyphen-separated segment
    # Split on hyphens: comp2-seg_base-app_n
    # But comp2 itself never contains hyphens, so split on first hyphen
    hyphen = remainder.find("-")
    if hyphen < 0:
        return None
    comp2 = remainder[:hyphen]
    rest = remainder[hyphen + 1:]  # seg_base-app_n or just app_n if seg_base empty

    # rest is either:
    #   seg_base-app_n  (e.g. z004-d0e404)
    #   -app_n          (empty seg_base, double-dash case — but we already consumed one hyphen)
    #   app_n           (if seg_base was empty, the double-dash means rest starts with -)
    # Actually for double-dash: apparaat_X_Y--app_n
    # After splitting comp2, remainder was "-app_n" so rest is "-app_n"[1:] = "" ... hmm
    # Let's re-examine: apparaat_AdsP1a_AdsD1--f0g402
    # after removing prefix: AdsP1a_AdsD1--f0g402
    # comp1=AdsP1a, remainder=AdsD1--f0g402
    # hyphen at index 5: comp2=AdsD1, rest=-f0g402
    # So rest starts with - meaning seg_base is empty
    if rest.startswith("-"):
        seg_base = ""
        app_n = rest[1:]
    else:
        # split on last hyphen to separate seg_base from app_n
        last_hyphen = rest.rfind("-")
        if last_hyphen < 0:
            # no hyphen — treat whole thing as app_n with empty seg_base
            seg_base = ""
            app_n = rest
        else:
            seg_base = rest[:last_hyphen]
            app_n = rest[last_hyphen + 1:]

    return {
        "comp1": comp1,
        "comp2": comp2,
        "seg_base": seg_base,
        "app_n": app_n,
    }


def parse_iframe_filename(filename: str):
    """
    Parse an iframe filename into its components.
    Pattern: AdsM1-{page}-iframe.html
    Returns dict with keys: document, page
    or None if it doesn't match.
    """
    m = re.match(r"^(AdsM1)-(.+)-iframe\.html$", filename)
    if not m:
        return None
    return {"document": m.group(1), "page": m.group(2)}


# ---------------------------------------------------------------------------
# Job builders
# ---------------------------------------------------------------------------

def apparatus_job(parsed: dict, source_xml: str, stylesheet: str) -> dict:
    """Build a manifest job dict for a two-witness apparatus page."""
    comp1 = parsed["comp1"]
    comp2 = parsed["comp2"]
    seg_base = parsed["seg_base"]
    app_n = parsed["app_n"]
    output_file = f"apparaat_{comp1}_{comp2}-{seg_base}-{app_n}.html"
    return {
        "output_file": output_file,
        "source_xml": source_xml,
        "stylesheet": stylesheet,
        "params": {
            "document": comp1,
            "comp1": comp1,
            "comp2": comp2,
            "id": seg_base,
            "app": app_n,
            "text": "doclinapp",
            "trans": "yes",
        }
    }


def iframe_job(parsed: dict, source_xml: str, stylesheet: str) -> dict:
    """Build a manifest job dict for an AdsM1 iframe page."""
    document = parsed["document"]
    page = parsed["page"]
    output_file = f"{document}-{page}-iframe.html"
    return {
        "output_file": output_file,
        "source_xml": source_xml,
        "stylesheet": stylesheet,
        "params": {
            "document": document,
            "page": page,
            "text": "iframe",
        }
    }


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    parser = argparse.ArgumentParser(
        description="Patch manifest-final.json with missing apparatus and iframe pages."
    )
    parser.add_argument("--manifest",    default="manifest-final.json")
    parser.add_argument("--missing",     default="missing.txt",
                        help="File listing missing apparatus filenames, one per line")
    parser.add_argument("--out",         default="manifest-final.json")
    parser.add_argument("--source-xml",  default="xml/ads.xml")
    parser.add_argument("--opd-xml",     default="xml/opd.xml")
    parser.add_argument("--stylesheet",  default="stylesheets/ads.xsl")
    args = parser.parse_args()

    # Load existing manifest
    manifest_path = Path(args.manifest)
    if not manifest_path.exists():
        print(f"ERROR: manifest not found: {manifest_path}", file=sys.stderr)
        sys.exit(1)
    with open(manifest_path, encoding="utf-8") as f:
        manifest = json.load(f)
    existing_files = {job["output_file"] for job in manifest}
    print(f"Loaded manifest: {len(manifest)} jobs")

    new_jobs = []
    skipped = 0
    errors = []

    # --- Missing comparison pages (b-witnesses vs Z-base) ---
    print(f"Missing comparison pages: {len(MISSING_COMPARISON_PAGES)}")
    for job in MISSING_COMPARISON_PAGES:
        filename = job["output_file"]
        if filename in existing_files:
            skipped += 1
            continue
        new_jobs.append(job)
        existing_files.add(filename)

    # --- Apparatus pages from missing.txt ---
    missing_path = Path(args.missing)
    if not missing_path.exists():
        print(f"ERROR: missing file list not found: {missing_path}", file=sys.stderr)
        sys.exit(1)

    missing_names = [
        line.strip() for line in missing_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    ]
    print(f"Missing apparatus pages: {len(missing_names)}")

    for filename in missing_names:
        if filename in existing_files:
            skipped += 1
            continue
        parsed = parse_apparatus_filename(filename)
        if parsed is None:
            errors.append(f"Could not parse: {filename}")
            continue
        # Determine source XML from prefix
        if filename.startswith("apparaat_Opd") or \
           (parsed["comp1"].startswith("Opd") or parsed["comp2"].startswith("Opd")):
            source_xml = args.opd_xml
        else:
            source_xml = args.source_xml
        job = apparatus_job(parsed, source_xml, args.stylesheet)
        new_jobs.append(job)
        existing_files.add(filename)

    # --- Iframe pages (hardcoded list) ---
    print(f"Iframe pages to add: {len(IFRAME_PAGES)}")
    for filename in IFRAME_PAGES:
        if filename in existing_files:
            skipped += 1
            continue
        parsed = parse_iframe_filename(filename)
        if parsed is None:
            errors.append(f"Could not parse iframe filename: {filename}")
            continue
        job = iframe_job(parsed, args.source_xml, args.stylesheet)
        new_jobs.append(job)
        existing_files.add(filename)

    # Report errors
    if errors:
        print(f"\nERRORS ({len(errors)}):")
        for e in errors:
            print(f"  {e}")

    # Write patched manifest
    patched = manifest + new_jobs
    out_path = Path(args.out)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(patched, f, indent=2, ensure_ascii=False)

    print(f"\nAdded:   {len(new_jobs)} jobs ({skipped} already present, skipped)")
    print(f"Total:   {len(patched)} jobs")
    print(f"Written: {out_path}")


if __name__ == "__main__":
    main()
