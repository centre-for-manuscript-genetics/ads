## Conversion to static HTML (2026)

### Removed

- Removed Flash-based zoom views (docfacszoom, docfacstopozoom)
- Removed "Printvriendelijke versie" from "Visualisatie" menu
- Inleiding: removed link to printable version of illustrative photographs


### Changed

- Changed the URL mapping throughout to produce unique pages with .html extension and no url parameters.
- Removed "Visualisatie" and "Variantenapparaat" menu in all views except TEXT VIEW, because on the other pages it does not make sense to have these options there.
- Text view (bovenlaag/Uiteindelijk resultaat): visualisation choice is no longer carried through navigation. Navigating away from a bovenlaag page and returning will revert to the default "Volledige transcriptie" view. This is a deliberate simplification to avoid the combinatorial explosion of static files that would result from carrying the view parameter through all internal links.
- Replaced `wz_dragdrop.js` with a position:fixed `<div>` and minimal vanilla JS (pointer events). `<dialog>` avoided for HTML4 transitional doctype compatibility. JS-off fallback: trigger link navigates directly to `-topo.html`. Sluit link excluded from pointerdown capture to preserve click behaviour.

### Added

