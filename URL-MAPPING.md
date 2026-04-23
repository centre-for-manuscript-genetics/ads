# URL Mapping: Cocoon → Static Filenames

This document describes how dynamic Cocoon URLs in the ADS edition were systematically converted into static, parameter-free filenames as part of the static site transformation.

It serves as:

* documentation of the mapping rules
* a reference for understanding filename structure
* a companion to `build/manifest-final.json`

## Overview

The most consequential structural change in the ADS conversion was the replacement of Cocoon’s parameter-based URL system with a fully static file structure.

In the original Cocoon application, a single pipeline generated many different views by accepting URL parameters (e.g. `document`, `text`, `page`, `trans`). Each request was resolved at runtime via the sitemap and passed to the XSLT.

In the static edition, each unique combination of parameters is materialized as a **distinct HTML file**, with a filename that encodes those parameters explicitly.

This document records the mapping rules used to translate dynamic Cocoon URLs into static filenames.

---

## General Principles

* Each dynamic URL corresponds to exactly **one static file**
* All parameters relevant to rendering are encoded in the filename
* Filenames are:

  * human-readable
  * deterministic
  * reversible (in principle)
* All internal links use these static filenames (no query parameters)

---

## Naming Conventions

| Pattern          | Meaning                                     |
| ---------------- | ------------------------------------------- |
| `Ads*` / `Opd*`  | Document identifiers (sigla)                |
| `-varianten`     | Variants visible (`trans=yes`)              |
| `-kies`          | Compare two witnesses                       |
| `-zinsvarianten` | Sentence-level navigation view (AdsM1 only) |
| `-facsimile`     | Image view                                  |
| `-topo`          | Topographic transcription                   |
| `-popup`         | Image + topo popup                          |
| `apparaat-`      | Apparatus (all witnesses)                   |
| `apparaat_`      | Apparatus (two witnesses)                   |
| `zin-`           | Sentence version view                       |
| `.xml`           | XML export                                  |

---

## 1. Text View

### 1.1 Standard Text View (`text=doclin`)

**Dynamic**

```
ads/Ads.htm?text=doclin&document=AdsM1&page=1
```

**Static**

```
ads/AdsM1.html
```

---

### 1.2 Text View with Variants (`trans=yes`)

**Dynamic**

```
ads/Ads.htm?text=doclin&document=AdsM1&page=1&trans=yes
```

**Static**

```
ads/AdsM1-varianten.html
```

**Note**
Some witnesses (e.g. AdsM2, AdsM3) contain multiple internal layers (a–f), handled within the XSLT.

---

### 1.3 Compare Two Witnesses (`text=doclincomp`)

**Dynamic**

```
ads/Ads.htm?text=doclincomp&document=AdsM1&page=1
```

**Static**

```
ads/AdsM1-kies.html
```

---

### 1.4 Sentence Navigation View (`text=doclinlay`)

**Dynamic**

```
ads/Ads.htm?text=doclinlay&document=AdsM1&page=1
```

**Static**

```
ads/AdsM1-zinsvarianten.html
```

**Constraint**
Generated for **AdsM1 only**.

---

## 2. XML View

### XML Export (`export=xml`)

**Dynamic**

```
ads/xml.xml?text=doclin&document=AdsM1&export=xml
```

**Static**

```
ads/AdsM1.xml
```

---

## 3. Image View

### 3.1 Facsimile (`text=docfacs`)

```
ads/AdsM1-1-facsimile.html
```

---

### 3.2 Topographic Transcription (`text=docfacstopo`)

```
ads/AdsM1-1-topo.html
```

---

### 3.3 Popup View (`text=docfacspop`)

```
ads/AdsM1-1-popup.html
```

---

### Removed

The following views were **removed** during conversion due to Flash dependency:

* `docfacszoom`
* `docfacstopozoom`

---

### Notes

* All image view filenames follow:

```
{document}-{page}-{view}.html
```

* Navigation (previous/next page and document) is preserved via static links.

---

## 4. Apparatus View

### 4.1 All Witnesses

**Dynamic**

```
ads/Ads.htm?text=doclinapp&id=z006&document=AdsD2&app=d0F406&trans=yes
```

**Static**

```
ads/apparaat-AdsD2-z006-d0F406.html
```

**Structure**

```
apparaat-{document}-{segBase}-{appId}.html
```

---

### 4.2 Two-Witness Comparison

**Dynamic**

```
ads/Ads.htm?text=doclinapp&id=z006&document=AdsM1&app=d0F404&trans=yes&comp1=AdsM1&comp2=AdsD2
```

**Static**

```
ads/apparaat_AdsM1_AdsD2-z006-d0F404.html
```

**Structure**

```
apparaat_{comp1}_{comp2}-{segBase}-{appId}.html
```

---

## 5. Sentence Version View

### Sentence-Level Navigation

**Dynamic**

```
ads/zin.htm?text=doclinlay&document=AdsM1&n=001&id=z001&corresp=03
```

**Static**

```
ads/zin-AdsM1-001-z001-03.html
```

**Structure**

```
zin-{document}-{n}-{segBase}-{corresp}.html
```

| Parameter | Meaning                  |
| --------- | ------------------------ |
| `n`       | sentence number          |
| `id`      | segment base (`@xml:id`) |
| `corresp` | segment type             |

---

## 6. Static Pages

| Page               | Static filename           |
| ------------------ | ------------------------- |
| Home               | `index.html`              |
| Inleiding          | `inleiding.html`          |
| Overlevering       | `overlevering.html`       |
| Gebruiksaanwijzing | `gebruiksaanwijzing.html` |
| Colofon            | `colofon.html`            |
| Webpublicatie 2026 | `2026.html`               |

