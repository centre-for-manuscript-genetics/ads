# Achter de Schermen — Electronic Edition

This repository contains the source files and build tooling for the
electronic edition of Willem Elsschot's *Achter de Schermen* and
*Opdracht* (the dedication published with *Tsjip*).

## The edition

The edition was originally published in 2007 as a CD-ROM publication by
Peter de Bruijn, Vincent Neyt, and Dirk Van Hulle. It presents all
known witnesses of both texts — manuscripts, typescripts, proofs, and
printed editions — in an integrated environment that allows readers to
compare versions, consult facsimile images, and follow the writing
process sentence by sentence. The texts are encoded in TEI P4 XML using
the parallel segmentation method; the original application was built on
Apache Cocoon 2.1.11 and ran as a dynamic web application on a Tomcat
server.


## The conversion

In 2026 the edition was converted to a fully static website as part of
the postdoctoral research project **"Lots of Copies Keep Stuff Safe:
Future-Proofing Digital Scholarly Editions"** (2025–2028), conducted by
Vincent Neyt at the Centre for Manuscript Genetics, University of
Antwerp. The project is funded by the **FWO — Fonds Wetenschappelijk
Onderzoek (Flemish Research Council)**.

The goal of the conversion was to produce a portable, maintenance-free,
and redistributable edition that can survive without server software,
database infrastructure, or ongoing technical maintenance — consistent
with the LOCKSS principle (lots of copies keep stuff safe). The static
edition is generated directly from the original TEI XML source files
using Saxon-HE and a Python build workflow, without scraping or
post-processing the dynamic application's output.

A full account of the conversion process, including the challenges of
manifest generation and the hybrid approach used to produce the
authoritative build manifest, will be documented in an accompanying article.


The static edition will be accessible at:
- **https://ads.uantwerpen.be**
- **https://centre-for-manuscript-genetics.github.io/achterdeschermen/**

## Repository structure

```text
ads/
├── cocoon/          (original Cocoon 2.1.11 application — for reference)
├── source/
│   ├── xml/         (TEI P4 XML source files)
│   ├── stylesheets/ (XSLT stylesheets)
│   └── dtd/         (document type definitions)
├── assets/
│   ├── images/      (facsimile images and interface graphics)
│   └── css/         (stylesheets)
├── build/           (build tooling and authoritative manifest)
├── output/          (build target — not tracked by Git)
└── CHANGES.md       (record of all changes made during conversion)
```

## Building the edition

See `build/README.md` for full instructions. In brief:

```bash
cd build
python build_server.py
```

Requirements: Python 3.8 or higher, Java 8 or higher.

The contents of `output/` will be published via the separate repository
[centre-for-manuscript-genetics/achterdeschermen](https://github.com/centre-for-manuscript-genetics/achterdeschermen)
and archived on Zenodo with a DOI.

## Credits

**Original edition**: Peter de Bruijn, Vincent Neyt, and Dirk Van Hulle (2007)

**Static conversion**: Vincent Neyt (2026)

**Funding**: FWO — Fonds Wetenschappelijk Onderzoek (Flemish Research
Council), postdoctoral fellowship, project "Lots of Copies Keep Stuff
Safe: Future-Proofing Digital Scholarly Editions" (2025–2028)

## Rights

The texts of *Achter de Schermen* and *Opdracht* and the facsimile images
are © Erven A. De Ridder (Willem Elsschot)/Athenaeum - Polak & Van Gennep,
Amsterdam. All rights reserved.

The electronic edition — including the TEI XML encoding, XSLT stylesheets,
and build tooling — is © Centre for Manuscript Genetics (Universiteit
Antwerpen) and Huygens Instituut (KNAW).

The static conversion and build scripts are made available under
[CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).