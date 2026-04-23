# conversion/

These scripts document the process used to produce `manifest-final.json`
during the 2026 conversion of the ADS edition from a dynamic Cocoon
application to a static website.

They are retained for documentary purposes and are not part of the normal
build workflow. `manifest-final.json` is a fixed editorial artifact and
cannot be reliably regenerated from these scripts alone.

## Scripts

| Script | Purpose |
|--------|---------|
| `generate-manifest.py` | Generative manifest from XML source (reference only) |
| `scrape-dynamic.py` | Crawl live Cocoon instance → `reachable-dynamic.txt` |
| `filter-manifest.py` | Cross-reference scrape vs generated manifest |
| `patch-manifest.py` | Add 873 missing jobs to produce `manifest-final.json` |
| `scrape-manifest.py` | Validate static output against manifest |
| `validate-links.py` | Check hrefs in output HTML against manifest |