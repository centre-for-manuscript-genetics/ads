# Build

This directory contains the tools for generating the static HTML edition from the TEI XML source files.

## Requirements

- Python 3.8 or higher
- Java 8 or higher (runtime only — no compilation needed)

All other dependencies are included in this directory.

## Directory structure

```text
build/
├── saxon/
│   ├── saxon-he-12.9.jar        (Saxon-HE XSLT processor)
│   ├── saxon-he-xqj-12.9.jar
│   ├── saxon-he-test-12.9.jar
│   └── lib/
│       ├── xmlresolver-5.3.3.jar
│       ├── xmlresolver-5.3.3-data.jar
│       └── jline-2.14.6.jar
├── BuildServer.java             (persistent Saxon worker — source)
├── BuildServer.class            (persistent Saxon worker — compiled, Java 8 target)
├── build_server.py              (primary build script)
├── build.py                     (fallback build script, no Java compilation required)
├── generate-manifest.py         (manifest generator)
├── validate-links.py            (link validator)
└── manifest.json                (generated — do not edit by hand)
```

Source XML and stylesheets are in `../source/xml/` and `../source/stylesheets/`. Output is written to `../output/`.

## Quickstart

```bash
# 1. Generate the manifest
python generate-manifest.py

# 2. Run a full build
python build_server.py

# 3. Validate links in the output
python validate-links.py
```

## Step 1: Generate the manifest

```bash
python generate-manifest.py
```

Reads the source XML files and writes `manifest.json`, which lists every output file to be generated along with its source XML, stylesheet, and XSLT parameters. The manifest covers all page types: text views, apparatus views, image views, sentence version pages, and static pages.

Re-run this script whenever the XML source changes in ways that affect which output files should exist — for example, after adding or removing witnesses or `<app>` elements. Do not edit `manifest.json` by hand.

Current manifest size: ~41,000 jobs.

## Step 2: Build

### Primary: `build_server.py`

```bash
python build_server.py [options]
```

The primary build tool. Spawns a pool of persistent Java worker processes, each running Saxon-HE. Each worker compiles the XSLT stylesheets once on startup and reuses them for all subsequent jobs, eliminating the per-file JVM startup and stylesheet compilation overhead of the fallback script.

**Measured performance: ~79 jobs/sec with 5 workers — full build (~41,000 files) in under 9 minutes.**

Options:

| Flag | Default | Description |
|------|---------|-------------|
| `--workers N` | 10 | Number of parallel worker processes. Recommended: 5–10 on a modern laptop, 3 on a Raspberry Pi 4. |
| `--incremental` | off | Skip files whose output is newer than all source XML and stylesheet files. Use for rebuilds after partial changes. |
| `--filter PATTERN` | none | Only build files whose output filename contains PATTERN. Useful for rebuilding a subset, e.g. `--filter apparaat` or `--filter zin-`. |
| `--dry-run` | off | Print job lines without running any transforms. |

Examples:

```bash
# Full build with 5 workers
python build_server.py --workers 5

# Incremental rebuild after editing a stylesheet
python build_server.py --incremental

# Rebuild only apparatus pages
python build_server.py --filter apparaat --incremental

# Rebuild only sentence version pages
python build_server.py --filter zin- --incremental
```

A summary log is written to `build_server.log` after each run.

`BuildServer.class` is included in the repository and requires no compilation step. It was compiled targeting Java 8 (`-source 8 -target 8`) and will run on Java 8 or any later version.

If for any reason you need to recompile it:

```bash
javac -source 8 -target 8 -cp "saxon/saxon-he-12.9.jar" BuildServer.java
```

Note: compile with `javac` version 8, or use the `-source 8 -target 8` flags with a newer `javac`, to ensure the resulting class file runs on Java 8 runtimes.

### Fallback: `build.py`

```bash
python build.py [options]
```

A simpler build script that invokes Saxon as a subprocess once per output file. No Java compilation or persistent processes required — it will work on any machine with Python and `java` on the PATH. Use this if `build_server.py` fails due to a Java environment issue.

Performance is significantly slower (~2 jobs/sec) because of per-file JVM startup overhead. A full build takes several hours.

Supports the same `--workers N`, `--incremental`, and `--filter PATTERN` flags as `build_server.py`. Writes a summary log to `build.log`.

## Step 3: Validate links

```bash
python validate-links.py
```

Checks all local `href` values in the generated HTML output against the manifest. Reports links pointing to files that were not generated. Non-page assets (CSS, images, JavaScript) are excluded from validation.

Results are written to `validate.log`. Use `--filter PATTERN` to validate a subset of output files.

Run validation after every full build to catch broken internal links before publishing.

## Publishing

After a successful build and validation, the contents of `../output/` are pushed to the separate repository `centre-for-manuscript-genetics/achterdeschermen` and served via GitHub Pages at:

```
https://centre-for-manuscript-genetics.github.io/achterdeschermen/
```

A `.nojekyll` file must be present at the root of `achterdeschermen` to prevent Jekyll from suppressing files beginning with an underscore.

For long-term archival, a ZIP of `../output/` is deposited to Zenodo with a DOI.
