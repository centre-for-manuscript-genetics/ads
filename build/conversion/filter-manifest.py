#!/usr/bin/env python3
"""
filter-manifest.py — cross-reference reachable-dynamic.txt against manifest.json
to produce manifest-final.json containing only the pages the edition actually needs.

Usage:
    python filter-manifest.py [options]

Options:
    --dynamic FILE    Dynamic scrape list (default: reachable-dynamic.txt)
    --manifest FILE   Input manifest (default: manifest.json)
    --out FILE        Output manifest (default: manifest-final.json)
    --log FILE        Log file (default: filter.log)

Reports:
    - Files in dynamic list found in manifest     → included in manifest-final.json
    - Files in dynamic list NOT in manifest       → missing (need to be added)
    - Files in manifest NOT in dynamic list       → superfluous (over-generated)
"""

import argparse
import json
import logging
import sys
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(
        description="Filter manifest to only pages reachable in the dynamic edition."
    )
    parser.add_argument("--dynamic",  default="reachable-dynamic.txt")
    parser.add_argument("--manifest", default="manifest.json")
    parser.add_argument("--out",      default="manifest-final.json")
    parser.add_argument("--log",      default="filter.log")
    args = parser.parse_args()

    log_file = Path(args.log)
    logging.basicConfig(
        level=logging.INFO,
        format="%(message)s",
        handlers=[
            logging.FileHandler(log_file, encoding="utf-8", mode="w"),
            logging.StreamHandler(sys.stdout),
        ]
    )

    # Load dynamic scrape list
    dynamic_path = Path(args.dynamic)
    if not dynamic_path.exists():
        logging.error(f"Dynamic scrape list not found: {dynamic_path}")
        sys.exit(1)
    dynamic_names = set(
        line.strip() for line in dynamic_path.read_text(encoding="utf-8").splitlines()
        if line.strip()
    )
    logging.info(f"Dynamic scrape list: {len(dynamic_names)} pages")

    # Load manifest
    manifest_path = Path(args.manifest)
    if not manifest_path.exists():
        logging.error(f"Manifest not found: {manifest_path}")
        sys.exit(1)
    with open(manifest_path, encoding="utf-8") as f:
        manifest = json.load(f)
    logging.info(f"Manifest:            {len(manifest)} jobs")

    # Index manifest by output_file
    manifest_index = {}
    for job in manifest:
        name = Path(job["output_file"]).name
        manifest_index[name] = job

    # Cross-reference
    found      = []   # in dynamic list AND in manifest
    missing    = []   # in dynamic list but NOT in manifest
    superfluous = []  # in manifest but NOT in dynamic list

    for name in sorted(dynamic_names):
        if name in manifest_index:
            found.append(name)
        else:
            missing.append(name)

    manifest_names = set(Path(job["output_file"]).name for job in manifest)
    for name in sorted(manifest_names):
        if name not in dynamic_names:
            superfluous.append(name)

    # Write manifest-final.json
    final_jobs = [manifest_index[name] for name in sorted(dynamic_names)
                  if name in manifest_index]
    out_path = Path(args.out)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(final_jobs, f, indent=2, ensure_ascii=False)

    # Report
    logging.info("")
    logging.info(f"Results:")
    logging.info(f"  Matched (in both):          {len(found):>6}")
    logging.info(f"  Missing (need to add):      {len(missing):>6}")
    logging.info(f"  Superfluous (over-generated):{len(superfluous):>6}")
    logging.info(f"  manifest-final.json jobs:   {len(final_jobs):>6}")
    logging.info("")

    if missing:
        logging.info(f"MISSING FILES ({len(missing)}) — in dynamic list but not in manifest:")
        for name in missing:
            logging.info(f"  {name}")
        logging.info("")

    if superfluous:
        logging.info(f"SUPERFLUOUS FILES ({len(superfluous)}) — in manifest but not in dynamic list:")
        for name in superfluous:
            logging.info(f"  {name}")
        logging.info("")

    logging.info(f"Written to: {out_path}")
    logging.info(f"Log:        {log_file}")

    if missing:
        sys.exit(1)  # signal that gaps remain


if __name__ == "__main__":
    main()
