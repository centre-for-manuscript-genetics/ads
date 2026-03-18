## Conversion to static HTML (2026)

### Removed
- Removed Flash-based zoom views (docfacszoom, docfacstopozoom)
- Removed "Printvriendelijke versie" from "Visualisatie" menu
- Removed "Visualisatie" and "Variantenapparaat" menu in all views except text view
- Inleiding: removed link to printable version of illustrative photographs

### Changed
- URL mapping redesigned throughout: all pages now have unique `.html` filenames with no URL parameters
- Text view ("Uiteindelijk resultaat" / "Volledige transcriptie"): visualisation choice is no longer carried through navigation. Navigating away from a "Uiteindelijk resultaat" page and returning reverts to the default view. This is a deliberate simplification to avoid the combinatorial explosion of static files that would result from carrying the view parameter through all internal links.
- "Kies 2 versies" redesigned as two-step static navigation, replacing the JS-driven form (`warp()` function, `<form>`, `<select>`)
- Navigation menu converted from JS-driven dropdown (`chrome.js`) to pure CSS `:hover` dropdowns
- Quicklink and note popups converted from `overlib.js` to lightweight vanilla JS with graceful degradation
- Draggable topographic transcription popup converted from `wz_dragdrop.js` to a `position:fixed` div with minimal vanilla JS; JS-off fallback navigates directly to `-topo.html`
- `MM_openBrWindow` XML export link converted to clean `href` + `onclick` with JS-off fallback
- Outer page structure converted from `<center>` + nested layout tables to `div.container` + `div.header` with CSS centering; deprecated table presentation attributes (`align`, `cellpadding`, `cellspacing`, `border`, `width`) moved to CSS; `<center>` removed; `div.header` given `overflow: hidden` clearfix to prevent collapse from floated children
- HTML sustainability review: `<strike>` → `<del>`; `<b>` → `<strong>`; `<font color="...">` → `<span class="...">`; block-level `<add>` content wrapped in `<div>` rather than `<span>`; nested `<del>` rendered as `<span class="del">`; `<a name="...">` → `<a id="...">`; all `<img>` tags given `alt` attributes; page break anchor ids prefixed with `p`; `emph[@rend='signed']` outputs `<span class="signed">` inside `<p>`, `<div class="signed">` elsewhere; `<div class="variant">` and `<ul>`/`<li>` inside inline contexts replaced with `<span class="variant">` and `<span class="variant-item">` to avoid block-in-inline validity errors

### Known limitations
- Two note popups fall between paragraph elements due to `<pb>` placement in the source XML. The resulting orphaned `<span>` elements are technically invalid HTML but render correctly in all browsers. Not fixable at the XSLT level without modifying the source XML.
- Nested `<del>` within `<del>` (reflecting legitimate TEI encoding of overlapping deletions) cannot be represented as nested `<del>` in HTML; inner deletions are rendered as `<span class="del">` instead.

### Added

- Added `<meta>` tags throughout: `charset`, `viewport`, `description`, `author`, Dublin Core (`DC.title`, `DC.creator`, `DC.date`, `DC.language`, `DC.rights`) for correct character rendering, accessibility, and long-term preservation discoverability