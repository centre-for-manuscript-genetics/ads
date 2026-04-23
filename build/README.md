# Build

This directory contains the tools for generating the static HTML edition
from the TEI XML source files.

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
├── conversion/
│   ├── generate-manifest.py     (generative manifest from XML source — reference only)
│   ├── scrape-dynamic.py        (crawl live Cocoon instance)
│   ├── filter-manifest.py       (cross-reference scrape vs generated manifest)
│   ├── patch-manifest.py        (add missing jobs to manifest)
│   ├── scrape-manifest.py       (validate static output against manifest)
│   ├── validate-links.py        (check hrefs in output HTML against manifest)
│   └── README.md                (explanation of conversion process)
├── BuildServer.java             (persistent Saxon worker — source)
├── BuildServer.class            (persistent Saxon worker — compiled, Java 8 target)
├── build_server.py              (primary build script)
├── build.py                     (fallback build script)
└── manifest-final.json          (authoritative build manifest — 54,732 jobs)
```

Source XML and stylesheets are in `../source/xml/` and
`../source/stylesheets/`. Output is written to `../output/`.

Source XML and stylesheets are in `../source/xml/` and
`../source/stylesheets/`. Output is written to `../output/`.

## The manifest

`manifest-final.json` is the authoritative list of all 54,732 output files,
each with its source XML, stylesheet, and XSLT parameters. It is a fixed
editorial artifact and should be treated as read-only.

**The manifest cannot be regenerated from the source XML alone.** The XSLT
stylesheets encode implicit editorial logic — governing witness combinations,
subwitness inheritance, and apparatus structure — that is not fully
recoverable from the source files. The manifest was produced by a hybrid
process: empirical discovery via the live Cocoon application (which served
as ground truth), cross-referenced against parameter mappings derived from
the source XML, with residual gaps patched manually. This process will be
documented in an article. The scripts used during this process
are preserved in `conversion/` for documentary purposes; they are not part
of the normal build workflow. Do not attempt to regenerate the manifest by
parsing the source XML; the result will be both incomplete and over-inclusive.

## Quickstart

```bash
# Run a full build
python build_server.py

# Run an incremental rebuild after editing stylesheets or XML
python build_server.py --incremental
```

## Building

### Primary: `build_server.py`

```bash
python build_server.py [options]
```

The primary build tool. Spawns a pool of persistent Java worker processes,
each running Saxon-HE. Each worker compiles the XSLT stylesheets once on
startup and reuses them for all subsequent jobs, eliminating per-file JVM
startup overhead.

**Measured performance: 230.7 jobs/sec on Apple M5 (14 workers) —
full build (54,732 files) in under 4 minutes.**

Options:

| Flag | Default | Description |
|------|---------|-------------|
| `--workers N` | 10 | Number of parallel worker processes. Recommended: 14 on Apple M5, 10 on a modern laptop, 3 on a Raspberry Pi 4. |
| `--incremental` | off | Skip files whose output is newer than all source XML and stylesheet files. |
| `--filter PATTERN` | none | Only build files whose output filename contains PATTERN. |
| `--dry-run` | off | Print job lines without running any transforms. |

Examples:

```bash
# Full build with 14 workers
python build_server.py --workers 14

# Incremental rebuild after editing a stylesheet
python build_server.py --incremental

# Rebuild only apparatus pages
python build_server.py --filter apparaat --incremental

# Rebuild only sentence version pages
python build_server.py --filter zin- --incremental
```

A summary log is written to `build_server.log` after each run.

`BuildServer.class` is included in the repository and requires no
compilation step. It was compiled targeting Java 8 (`-source 8 -target 8`)
and will run on Java 8 or any later version. If you need to recompile:

```bash
javac -source 8 -target 8 -cp "saxon/saxon-he-12.9.jar" BuildServer.java
```

### Fallback: `build.py`

```bash
python build.py [options]
```

A simpler build script that invokes Saxon as a subprocess once per output
file. No persistent processes required — works on any machine with Python
and `java` on the PATH. Use this if `build_server.py` fails due to a Java
environment issue. Performance is significantly slower (~2 jobs/sec).

Supports the same `--workers N`, `--incremental`, and `--filter PATTERN`
flags as `build_server.py`.
