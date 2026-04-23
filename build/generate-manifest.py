from __future__ import annotations
from dataclasses import dataclass, asdict
from pathlib import Path
from typing import Iterable, List, Dict, Optional
import json
import re
from lxml import etree

# ---------------------------------------------------------------------------
# Configuration — all paths relative to this script's directory (ads/build/)
# ---------------------------------------------------------------------------
BASE_DIR       = Path(__file__).resolve().parent
REPO_DIR       = BASE_DIR.parent
SOURCE_DIR     = REPO_DIR / "source" / "xml"
STYLESHEET_DIR = REPO_DIR / "source" / "stylesheets"

# ----------------------------
# Data classes
# ----------------------------
@dataclass(frozen=True)
class EditionConfig:
    prefix: str        # "Ads" or "Opd"
    source_xml: str    # "xml/ads.xml" or "xml/opd.xml"  (relative, for manifest params)
    stylesheet: str    # "stylesheets/ads.xsl"           (relative, for manifest params)
    zin: bool          # whether to generate -zinsvarianten pages

@dataclass(frozen=True)
class Witness:
    n: str
    sigil: str
    rend: Optional[str]
    label: str

@dataclass(frozen=True)
class CompareTarget:
    raw_n: str
    href_value: str
    kind: str  # plain | a | b

@dataclass(frozen=True)
class TocPage:
    document_id: str
    page_id: str
    page_n: str
    image_name: str

@dataclass(frozen=True)
class AppEntry:
    app_n: str
    seg_base: str
    varying_pairs: frozenset  # frozenset of frozenset({wit_a, wit_b}) that differ at this app

@dataclass(frozen=True)
class BuildJob:
    output_file: str
    source_xml: str
    stylesheet: str
    params: Dict[str, str]

# ----------------------------
# lxml parser
# ----------------------------
def make_parser() -> etree.XMLParser:
    """
    Shared lxml parser: recover=True tolerates malformed markup,
    resolve_entities=False avoids needing the DTD to expand named
    entities (safe here because we only access tags and attributes,
    never text content).
    """
    return etree.XMLParser(recover=True, resolve_entities=False)

def parse_xml(text: str, encoding: str = "utf-8") -> etree._Element:
    parser = make_parser()
    return etree.fromstring(text.encode(encoding), parser)

# ----------------------------
# Parsing
# ----------------------------
def parse_witlist(xml_text: str, encoding: str = "iso-8859-1") -> List[Witness]:
    """
    Parse witnesses from //witList in the edition source XML (ads.xml or opd.xml).
    Replaces the separate ads-witlist.xml / opd-witlist.xml files.
    """
    root = parse_xml(xml_text, encoding=encoding)
    witnesses: List[Witness] = []
    for el in root.iter("witness"):
        witnesses.append(
            Witness(
                n=el.attrib.get("n", "").strip(),
                sigil=el.attrib.get("sigil", "").strip(),
                rend=el.attrib.get("rend"),
                label=" ".join("".join(el.itertext()).split()),
            )
        )
    return witnesses

def parse_toc(xml_text: str) -> Dict[str, List[TocPage]]:
    """
    Returns a mapping like:
        {
            "AdsM1": [TocPage(...), TocPage(...), ...],
            "AdsD1": [...],
        }
    Uses @id on <document> and @id / @n on <page>.
    Image filename is normalized to {document}-{page}.jpg
    """
    root = parse_xml(xml_text, encoding="latin-1")
    result: Dict[str, List[TocPage]] = {}
    for doc in root.iter("document"):
        document_id = doc.attrib.get("id", "").strip()
        if not document_id:
            continue
        pages: List[TocPage] = []
        for page in doc.iter("page"):
            page_id = page.attrib.get("id", "").strip()
            page_n  = page.attrib.get("n", "").strip()
            image_name = f"{document_id}-{page_id}.jpg"
            pages.append(
                TocPage(
                    document_id=document_id,
                    page_id=page_id,
                    page_n=page_n,
                    image_name=image_name,
                )
            )
        result[document_id] = pages
    return result

def parse_segs(xml_text: str) -> List[dict]:
    """
    Parse <seg> elements from //text[@id='AdsM1'] in ads.xml.
    Returns a flat list of dicts with keys: n, base, corresp.
    Sentence-version pages are generated for AdsM1 only.
    corresp is @type from the seg, or "" when @type is absent.
    """
    root = parse_xml(xml_text, encoding="iso-8859-1")
    segs = []
    for text_el in root.iter("text"):
        if text_el.attrib.get("id", "").strip() == "AdsM1":
            for seg in text_el.iter("seg"):
                n      = seg.attrib.get("n",    "").strip()
                base   = seg.attrib.get("base", "").strip()
                if not (n and base):
                    continue
                corresp = seg.attrib.get("type", "").strip()
                segs.append({"n": n, "base": base, "corresp": corresp})
            break  # only need the first matching text element
    return segs

def sentence_version_jobs(
    segs: List[dict],
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/zin.xsl",
) -> List[BuildJob]:
    """
    Generate one sentence-version page per seg in AdsM1.
    Filename pattern: zin-AdsM1-{n}-{base}-{corresp}.html
    corresp may be "" for segs where @type is absent, producing
    filenames ending in -.html (e.g. zin-AdsM1-004a-z004-.html).
    XSLT params: document, n, id (=base), corresp, text
    """
    jobs: List[BuildJob] = []
    for seg in segs:
        jobs.append(
            BuildJob(
                output_file=f"zin-AdsM1-{seg['n']}-{seg['base']}-{seg['corresp']}.html",
                source_xml=source_xml,
                stylesheet=stylesheet,
                params={
                    "document": "AdsM1",
                    "n": seg["n"],
                    "id": seg["base"],
                    "corresp": seg["corresp"],
                    "text": "doclinlay",
                },
            )
        )
    return jobs

def parse_apps(
    xml_text: str,
    z_to_subs: Dict[str, List[str]],
    base_to_a: Dict[str, str],
) -> List[AppEntry]:
    """
    Parse all <app> elements and compute varying witness pairs per app/@n.
    z_to_subs maps each Z-base sigil to the list of subwitnesses (b–f) that
    inherit from it when absent from an <app>. Example:
        {"AdsZM2": ["AdsM2b", "AdsM2c", "AdsM2d", "AdsM2e", "AdsM2f"],
         "AdsZM3": ["AdsM3b"],
         "AdsZP1": ["AdsP1b"]}
    base_to_a maps each synthetic base document to its a-witness. Example:
        {"AdsM2": "AdsM2a", "AdsM3": "AdsM3a", "AdsP1": "AdsP1a",
         "OpdP1": "OpdP1a"}
    Absent-witness fix (three parts):
    Part A — Z-base present in varying_pairs: clone Z-base partners for each
    absent b–f subwitness.
    Part B — Z-base absent but a-witness present and varying: use a-witness
    partners as proxy. Handles apps like azze458 where AdsZM2 is absent but
    AdsM2a varies.
    Part C — Synthetic base documents: the XSLT renders AdsM2 pages by finding
    AdsM2a readings (4th char != 'Z' branch in app template). So AdsM2 varies
    with exactly the same witnesses as AdsM2a at each app. Clone AdsM2a pairs
    substituting AdsM2 for AdsM2a.
    """
    root = parse_xml(xml_text, encoding="iso-8859-1")
    # Build reverse mapping: Z-base -> a-witness (e.g. "AdsZM2" -> "AdsM2a")
    z_to_a: Dict[str, str] = {}
    for z_base in z_to_subs:
        m = re.match(r"^(Ads|Opd)Z(.+)$", z_base)
        if m:
            z_to_a[z_base] = f"{m.group(1)}{m.group(2)}a"
    entries_dict: Dict[tuple, set] = {}
    for app in root.iter("app"):
        app_n = app.attrib.get("n", "").strip()
        if not app_n:
            continue
        # Walk up to find nearest ancestor <seg @base>
        seg_base = ""
        node = app.getparent()
        while node is not None:
            if node.tag == "seg":
                seg_base = node.attrib.get("base", "").strip()
                break
            node = node.getparent()
        # Build list of witness sets per <rdg>
        rdg_witness_sets = []
        for rdg in app:
            if rdg.tag != "rdg":
                continue
            wit_attr = rdg.attrib.get("wit", "").strip()
            wits = frozenset(w.strip() for w in wit_attr.split() if w.strip())
            if wits:
                rdg_witness_sets.append(wits)
        # Two witnesses vary if they appear in different <rdg> elements
        varying_pairs: set = set()
        for i, wits_a in enumerate(rdg_witness_sets):
            for wits_b in rdg_witness_sets[i + 1:]:
                for wit_a in wits_a:
                    for wit_b in wits_b:
                        varying_pairs.add(frozenset({wit_a, wit_b}))
        # For nested apps: register pairs between witnesses in the ancestor
        # <rdg> containing this app and witnesses in sibling <rdg> elements
        # of each ancestor <app>.
        node = app.getparent()
        while node is not None:
            if node.tag == "rdg":
                containing_wit_attr = node.attrib.get("wit", "").strip()
                containing_wits = frozenset(
                    w.strip() for w in containing_wit_attr.split() if w.strip()
                )
                parent_app = node.getparent()
                if parent_app is not None and parent_app.tag == "app":
                    for sibling_rdg in parent_app:
                        if sibling_rdg.tag != "rdg" or sibling_rdg is node:
                            continue
                        sibling_wit_attr = sibling_rdg.attrib.get("wit", "").strip()
                        sibling_wits = frozenset(
                            w.strip() for w in sibling_wit_attr.split() if w.strip()
                        )
                        for wit_containing in containing_wits:
                            for wit_sibling in sibling_wits:
                                varying_pairs.add(frozenset({wit_containing, wit_sibling}))
            node = node.getparent()
        # Collect all witnesses explicitly present in this app
        present_wits: set = set()
        for wits in rdg_witness_sets:
            present_wits.update(wits)
        extra_pairs: set = set()
        # Parts A and B: absent b–f subwitnesses
        for z_base, subs in z_to_subs.items():
            # Part A: find partners of the Z-base directly from varying_pairs
            z_partners: set = set()
            for pair in varying_pairs:
                pair_list = list(pair)
                if z_base == pair_list[0]:
                    z_partners.add(pair_list[1])
                elif z_base == pair_list[1]:
                    z_partners.add(pair_list[0])
            # Part B: Z-base absent but a-witness present and varying —
            # use a-witness's partners as proxy for the Z-base.
            if not z_partners:
                a_wit = z_to_a.get(z_base)
                if a_wit and a_wit in present_wits:
                    for pair in varying_pairs:
                        pair_list = list(pair)
                        if a_wit == pair_list[0]:
                            z_partners.add(pair_list[1])
                        elif a_wit == pair_list[1]:
                            z_partners.add(pair_list[0])
                    # b–f witnesses share the same reading as a at this app
                    z_partners.discard(a_wit)
            if not z_partners:
                continue
            for sub in subs:
                if sub in present_wits:
                    continue  # already handled via normal path
                for partner in z_partners:
                    extra_pairs.add(frozenset({sub, partner}))
        # Part C: synthetic base documents (AdsM2, AdsM3, AdsP1, OpdP1).
        # The XSLT renders these by finding their a-witness readings, so each
        # base document varies with the same witnesses as its a-witness.
        for base_doc, a_wit in base_to_a.items():
            base_partners: set = set()
            for pair in varying_pairs:
                pair_list = list(pair)
                if a_wit == pair_list[0]:
                    base_partners.add(pair_list[1])
                elif a_wit == pair_list[1]:
                    base_partners.add(pair_list[0])
            # Also check pairs added by Parts A/B (extra_pairs so far)
            for pair in extra_pairs:
                pair_list = list(pair)
                if a_wit == pair_list[0]:
                    base_partners.add(pair_list[1])
                elif a_wit == pair_list[1]:
                    base_partners.add(pair_list[0])
            # Base doc shares reading with its a-witness — they don't vary
            base_partners.discard(a_wit)
            for partner in base_partners:
                extra_pairs.add(frozenset({base_doc, partner}))
        varying_pairs.update(extra_pairs)
        key = (app_n, seg_base)
        if key not in entries_dict:
            entries_dict[key] = set()
        entries_dict[key].update(varying_pairs)
    return [
        AppEntry(
            app_n=app_n,
            seg_base=seg_base,
            varying_pairs=frozenset(pairs),
        )
        for (app_n, seg_base), pairs in entries_dict.items()
    ]

# ----------------------------
# Witness comparison logic
# ----------------------------
def split_prefix_rest(wit: str) -> tuple:
    m = re.match(r"^(Ads|Opd)(.+)$", wit)
    if not m:
        raise ValueError(f"Cannot split witness prefix/rest: {wit}")
    return m.group(1), m.group(2)

def sixth_char(wit: str) -> str:
    return wit[5] if len(wit) >= 6 else ""

def z_base_for_subwitness(wit: str) -> str:
    """
    Returns the Z-base sigil for any b–f subwitness.
    AdsM2b -> AdsZM2,  AdsM2c -> AdsZM2,  AdsM3b -> AdsZM3,
    AdsP1b -> AdsZP1,  OpdP1b -> OpdZP1   (etc.)
    Works for any suffix letter b–f.
    """
    prefix, rest = split_prefix_rest(wit)
    sixth = sixth_char(wit)
    if sixth not in "bcdef":
        raise ValueError(f"Expected b–f witness, got: {wit}")
    base = rest[:-1]  # strip the suffix letter
    return f"{prefix}Z{base}"

def comparison_targets(witnesses: Iterable[Witness]) -> List[CompareTarget]:
    targets: List[CompareTarget] = []
    for w in witnesses:
        sixth = sixth_char(w.n)
        if sixth == "":
            targets.append(CompareTarget(raw_n=w.n, href_value=w.n, kind="plain"))
        elif sixth == "a":
            targets.append(CompareTarget(raw_n=w.n, href_value=w.n, kind="a"))
        elif sixth in "bcdef":
            targets.append(
                CompareTarget(
                    raw_n=w.n,
                    href_value=z_base_for_subwitness(w.n),
                    kind="b",  # keep kind="b" for compatibility
                )
            )
        else:
            continue  # any other sixth characters silently skipped
    seen = set()
    deduped: List[CompareTarget] = []
    for t in targets:
        key = (t.raw_n, t.href_value, t.kind)
        if key not in seen:
            seen.add(key)
            deduped.append(t)
    return deduped

# ----------------------------
# Helper: derive synthetic base documents
# ----------------------------
def synthetic_base_documents(
    edition_witnesses: List[Witness],
    toc_pages: Dict[str, List[TocPage]],
    edition_prefix: str,
) -> List[str]:
    """
    Returns TOC document ids that:
      1. start with edition_prefix
      2. are NOT already present as a bare witness @n
      3. DO have at least one witness whose @n starts with that document id
         (e.g. AdsM2 is a base for AdsM2a..AdsM2f)
    These need witness-level and comparison pages even though they are
    not themselves declared as witnesses in witList.
    """
    witness_ns = {w.n for w in edition_witnesses}
    result: List[str] = []
    for doc_id in toc_pages:
        if not doc_id.startswith(edition_prefix):
            continue
        if doc_id in witness_ns:
            continue
        if any(w.n.startswith(doc_id) for w in edition_witnesses):
            result.append(doc_id)
    return result

# ----------------------------
# Job generators
# ----------------------------
def static_page_jobs() -> List[BuildJob]:
    return [
        BuildJob(
            output_file="index.html",
            source_xml="xml/ads.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "home", "document": "AdsM1"},
        ),
        BuildJob(
            output_file="overlevering.html",
            source_xml="xml/overlevering.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "overlevering", "document": "overlevering"},
        ),
        BuildJob(
            output_file="gebruiksaanwijzing.html",
            source_xml="xml/gebruiksaanwijzing.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "gebruiksaanwijzing", "document": "gebruiksaanwijzing"},
        ),
        BuildJob(
            output_file="inleiding.html",
            source_xml="xml/inleiding.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "inleiding", "document": "inleiding"},
        ),
        BuildJob(
            output_file="colofon.html",
            source_xml="xml/colofon.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "colofon", "document": "colofon"},
        ),
        BuildJob(
            output_file="2026.html",
            source_xml="xml/ads.xml",
            stylesheet="stylesheets/ads.xsl",
            params={"text": "2026", "document": "2026"},
        ),
    ]

def witness_level_jobs(
    document: str,
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/ads.xsl",
    zin: bool = True,
) -> List[BuildJob]:
    """
    Generates the standard per-witness pages.
    -zinsvarianten.html is generated for AdsM1 only (zin=True and document='AdsM1').
    kies2 omitted intentionally from all editions.
    """
    jobs = [
        BuildJob(
            output_file=f"{document}.html",
            source_xml=source_xml,
            stylesheet=stylesheet,
            params={"document": document, "page": "1", "text": "doclin"},
        ),
        BuildJob(
            output_file=f"{document}-varianten.html",
            source_xml=source_xml,
            stylesheet=stylesheet,
            params={"document": document, "page": "1", "text": "doclin", "trans": "yes"},
        ),
        BuildJob(
            output_file=f"{document}-bovenlaag.html",
            source_xml=source_xml,
            stylesheet=stylesheet,
            params={"document": document, "page": "1", "text": "doclin", "view": "bovenlaag"},
        ),
        BuildJob(
            output_file=f"{document}-kies.html",
            source_xml=source_xml,
            stylesheet=stylesheet,
            params={"document": document, "page": "1", "text": "doclincomp"},
        ),
        BuildJob(
            output_file=f"{document}.xml",
            source_xml=source_xml,
            stylesheet="stylesheets/xml.xsl",
            params={"document": document, "export": "xml", "text": "doclin"},
        ),
    ]
    if zin and document == "AdsM1":
        jobs.append(
            BuildJob(
                output_file="AdsM1-zinsvarianten.html",
                source_xml=source_xml,
                stylesheet=stylesheet,
                params={"document": "AdsM1", "page": "1", "text": "doclinlay"},
            )
        )
    return jobs

def comparison_jobs(
    document: str,
    compare_targets: Iterable[CompareTarget],
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/ads.xsl",
) -> List[BuildJob]:
    """
    Generate text-view comparison pages for a document against all targets.
    Issue 2 fix: for b–f subwitnesses, also generates a comparison page
    against their own Z-base (e.g. AdsM2b-varianten-AdsZM2.html). This page
    is not produced by the normal target iteration because the only target
    that would produce href_value="AdsZM2" is AdsM2b itself, which is
    excluded by the raw_n == document skip condition.
    """
    jobs: List[BuildJob] = []
    targets_to_use = list(compare_targets)
    sixth = sixth_char(document)
    if sixth in "bcdef":
        z_base = z_base_for_subwitness(document)
        existing_hrefs = {t.href_value for t in targets_to_use}
        if z_base not in existing_hrefs:
            targets_to_use.append(
                CompareTarget(raw_n=z_base, href_value=z_base, kind="plain")
            )
    for target in targets_to_use:
        if target.raw_n == document:
            continue
        jobs.append(
            BuildJob(
                output_file=f"{document}-varianten-{target.href_value}.html",
                source_xml=source_xml,
                stylesheet=stylesheet,
                params={
                    "document": document,
                    "comp1": document,
                    "comp2": target.href_value,
                    "page": "1",
                    "text": "doclin",
                    "trans": "yes",
                },
            )
        )
    return jobs

def apparatus_jobs(
    app_entries: List[AppEntry],
    edition_witnesses: List[Witness],
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/ads.xsl",
) -> List[BuildJob]:
    """
    Generate one all-versions apparatus page per witness per app/@n.
    Filename pattern: apparaat-{document}-{seg_base}-{app_n}.html
    When seg_base is "" (app inside <head>), this produces the double-dash
    form: apparaat-{document}--{app_n}.html
    XSLT params: document, id (seg_base), app (app_n), text, trans
    """
    jobs: List[BuildJob] = []
    for entry in app_entries:
        for witness in edition_witnesses:
            jobs.append(
                BuildJob(
                    output_file=f"apparaat-{witness.n}-{entry.seg_base}-{entry.app_n}.html",
                    source_xml=source_xml,
                    stylesheet=stylesheet,
                    params={
                        "document": witness.n,
                        "id": entry.seg_base,
                        "app": entry.app_n,
                        "text": "doclinapp",
                        "trans": "yes",
                    },
                )
            )
    return jobs

def two_witness_apparatus_jobs(
    app_entries: List[AppEntry],
    all_documents: List[str],
    targets: List[CompareTarget],
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/ads.xsl",
) -> List[BuildJob]:
    """
    Generate two-witness apparatus pages for all documents against all targets.
    Accepts all_documents as a flat list of document id strings so that
    synthetic base documents (AdsM2, AdsM3, AdsP1, OpdP1) are included
    as comp1 alongside real witnesses.
    """
    jobs: List[BuildJob] = []
    for document in all_documents:
        for target in targets:
            if target.raw_n == document:
                continue
            pair = frozenset({document, target.href_value})
            for entry in app_entries:
                if pair not in entry.varying_pairs:
                    continue
                jobs.append(
                    BuildJob(
                        output_file=f"apparaat_{document}_{target.href_value}-{entry.seg_base}-{entry.app_n}.html",
                        source_xml=source_xml,
                        stylesheet=stylesheet,
                        params={
                            "document": document,
                            "comp1": document,
                            "comp2": target.href_value,
                            "id": entry.seg_base,
                            "app": entry.app_n,
                            "text": "doclinapp",
                            "trans": "yes",
                        },
                    )
                )
    return jobs

def image_view_jobs(
    toc_pages_by_document: Dict[str, List[TocPage]],
    allowed_documents: Optional[set] = None,
    source_xml: str = "xml/ads.xml",
    stylesheet: str = "stylesheets/ads.xsl",
    topo_documents: Optional[set] = None,
) -> List[BuildJob]:
    """
    Generate -facsimile.html for all documents.
    Generate -topo.html, -popup.html, -iframe.html only for documents
    in topo_documents (e.g. {"AdsM1"}).
    """
    jobs: List[BuildJob] = []
    for document_id, pages in toc_pages_by_document.items():
        if allowed_documents is not None and document_id not in allowed_documents:
            continue
        include_topo = topo_documents is not None and document_id in topo_documents
        for page in pages:
            jobs.append(
                BuildJob(
                    output_file=f"{document_id}-{page.page_id}-facsimile.html",
                    source_xml=source_xml,
                    stylesheet=stylesheet,
                    params={
                        "document": document_id,
                        "page": page.page_id,
                        "text": "docfacs",
                    },
                )
            )
            if include_topo:
                jobs.extend([
                    BuildJob(
                        output_file=f"{document_id}-{page.page_id}-topo.html",
                        source_xml=source_xml,
                        stylesheet=stylesheet,
                        params={
                            "document": document_id,
                            "page": page.page_id,
                            "text": "docfacstopo",
                        },
                    ),
                    BuildJob(
                        output_file=f"{document_id}-{page.page_id}-popup.html",
                        source_xml=source_xml,
                        stylesheet=stylesheet,
                        params={
                            "document": document_id,
                            "page": page.page_id,
                            "text": "docfacspop",
                        },
                    ),
                    BuildJob(
                        output_file=f"{document_id}-{page.page_id}-iframe.html",
                        source_xml=source_xml,
                        stylesheet=stylesheet,
                        params={
                            "document": document_id,
                            "page": page.page_id,
                            "text": "iframe",
                        },
                    ),
                ])
    return jobs

# ----------------------------
# Manifest builder
# ----------------------------
def dedupe_jobs(jobs: Iterable[BuildJob]) -> List[BuildJob]:
    seen = set()
    deduped: List[BuildJob] = []
    for job in jobs:
        key = (
            job.output_file,
            job.source_xml,
            job.stylesheet,
            tuple(sorted(job.params.items())),
        )
        if key not in seen:
            seen.add(key)
            deduped.append(job)
    return deduped

def build_manifest(
    editions: List[EditionConfig],
    toc_xml: str,
) -> List[BuildJob]:
    toc_pages = parse_toc(toc_xml)
    jobs: List[BuildJob] = []
    jobs.extend(static_page_jobs())

    # Parse AdsM1 segs once for sentence-version page generation.
    ads_source_xml_text = (SOURCE_DIR / "ads.xml").read_text(encoding="iso-8859-1")
    segs = parse_segs(ads_source_xml_text)

    for ed in editions:
        # Parse witnesses directly from //witList in the edition source XML.
        # Replaces the separate ads-witlist.xml / opd-witlist.xml files.
        source_xml_path = SOURCE_DIR / ed.source_xml.replace("xml/", "", 1)
        source_xml_text = source_xml_path.read_text(encoding="iso-8859-1")
        witnesses = parse_witlist(source_xml_text, encoding="iso-8859-1")
        edition_witnesses = [w for w in witnesses if w.n.startswith(ed.prefix)]
        edition_documents = {w.n for w in edition_witnesses}
        targets = comparison_targets(edition_witnesses)
        base_docs = synthetic_base_documents(edition_witnesses, toc_pages, ed.prefix)

        # Build z_to_subs: maps each Z-base sigil to the list of b–f subwitnesses
        # that inherit from it when absent from an <app>.
        # e.g. {"AdsZM2": ["AdsM2b", "AdsM2c", "AdsM2d", "AdsM2e", "AdsM2f"],
        #        "AdsZM3": ["AdsM3b"], "AdsZP1": ["AdsP1b"]}
        z_to_subs: Dict[str, List[str]] = {}
        for w in edition_witnesses:
            if sixth_char(w.n) in "bcdef":
                z_base = z_base_for_subwitness(w.n)
                if z_base not in z_to_subs:
                    z_to_subs[z_base] = []
                z_to_subs[z_base].append(w.n)

        # Build base_to_a: maps each synthetic base document to its a-witness.
        # The XSLT renders base document pages using the a-witness readings,
        # so the base document varies with the same witnesses as its a-witness.
        # e.g. {"AdsM2": "AdsM2a", "AdsM3": "AdsM3a", "AdsP1": "AdsP1a"}
        base_to_a: Dict[str, str] = {doc_id: doc_id + "a" for doc_id in base_docs}

        # source_xml_text already read above — reuse for parse_apps
        app_entries = parse_apps(source_xml_text, z_to_subs, base_to_a)

        # All document ids for two-witness apparatus generation:
        # real witnesses + synthetic base documents.
        all_document_ids = [w.n for w in edition_witnesses] + list(base_docs)

        # Real witnesses: witness-level and comparison pages
        for w in edition_witnesses:
            jobs.extend(witness_level_jobs(w.n, ed.source_xml, ed.stylesheet, ed.zin))
            jobs.extend(comparison_jobs(w.n, targets, ed.source_xml, ed.stylesheet))

        # Synthetic base documents: witness-level and comparison pages
        for doc_id in base_docs:
            jobs.extend(witness_level_jobs(doc_id, ed.source_xml, ed.stylesheet, ed.zin))
            jobs.extend(comparison_jobs(doc_id, targets, ed.source_xml, ed.stylesheet))

        # Apparatus pages: real witnesses only, all app/@n entries
        jobs.extend(
            apparatus_jobs(app_entries, edition_witnesses, ed.source_xml, ed.stylesheet)
        )

        # Two-witness apparatus pages: real witnesses + synthetic base documents
        jobs.extend(
            two_witness_apparatus_jobs(
                app_entries, all_document_ids, targets, ed.source_xml, ed.stylesheet
            )
        )

        # Sentence-version pages: AdsM1 only
        if ed.zin:
            jobs.extend(
                sentence_version_jobs(
                    segs=segs,
                    source_xml=ed.source_xml,
                    stylesheet="stylesheets/zin.xsl",
                )
            )

        # Image view covers both real witnesses and synthetic base docs
        image_allowed = edition_documents | set(base_docs)
        jobs.extend(
            image_view_jobs(
                toc_pages_by_document=toc_pages,
                allowed_documents=image_allowed,
                source_xml=ed.source_xml,
                stylesheet=ed.stylesheet,
                topo_documents={"AdsM1"},
            )
        )

    return dedupe_jobs(jobs)

def manifest_as_json(jobs: Iterable[BuildJob]) -> str:
    return json.dumps([asdict(job) for job in jobs], indent=2, ensure_ascii=False)

# ----------------------------
# Main
# ----------------------------
if __name__ == "__main__":
    toc_xml = (SOURCE_DIR / "toc.xml").read_text(encoding="latin-1")
    editions = [
        EditionConfig(
            prefix="Ads",
            source_xml="xml/ads.xml",
            stylesheet="stylesheets/ads.xsl",
            zin=True,
        ),
        EditionConfig(
            prefix="Opd",
            source_xml="xml/opd.xml",
            stylesheet="stylesheets/ads.xsl",
            zin=False,
        ),
    ]
    jobs = build_manifest(editions, toc_xml)
    print(f"Total jobs: {len(jobs)}")
    manifest_path = BASE_DIR / "manifest.json"
    manifest_path.write_text(manifest_as_json(jobs), encoding="utf-8")
    print(f"Wrote {manifest_path}")
