# Kuijpers Assets Library 🏗️

Centrale opslag voor statische bestanden, afbeeldingen en templates t.b.v. Kuijpers Klantvestiging ASML.
Deze repository fungeert als **CDN** (Content Delivery Network) voor Power Automate flows en e-mail templates.

## 📂 Mappenstructuur

- `images/`
  - `logos/`: Bedrijfslogo's (Kuijpers, partners) en varianten.
  - `icons/`: Iconen voor gebruik in HTML mails en UI (incl. social).
  - `locations/`: Routekaartjes, markers en plattegronden.
  - `signs/`: Parkeer- en bebording-afbeeldingen.
  - `qr-codes/`: QR-codes (PNG/SVG).
  - `other/`: Overige visuals, banners en illustraties.
- `templates/`
  - `email/`: HTML bronbestanden voor e-mail templates.
  - `pdf/`: PDF-uitvoer van templates of formulieren.
  - `screenshots/`: Screenshots voor documentatie en instructies.
- `workflows/`: Export van Power Automate flows (JSON) met `schema/`.
- `docs/`: Publieke documenten (gereserveerd, momenteel leeg).
- `KVA-QuickFlowLinker.html`: Flow dashboard voor directe toegang.

## 🚀 Gebruik (GitHub Pages)

Zodra **GitHub Pages** is ingeschakeld voor deze repo, zijn de bestanden direct benaderbaar via:

`https://royalkuijpers.github.io/assets/<pad>/<bestand>`

### Voorbeelden
- Logo: `https://royalkuijpers.github.io/assets/images/logos/kuijpers-logo.png`
- QR-code: `https://royalkuijpers.github.io/assets/images/qr-codes/QR-Pasaanvraag.png`
- Flow dashboard: `https://royalkuijpers.github.io/assets/KVA-QuickFlowLinker.html`

Let op: bestandsnamen met spaties of speciale tekens moeten URL-encoded worden (bijv. spatie → `%20`).

## 🛠️ Scripts

- `setup.ps1`: (Her)initialiseert mappenstructuur en basisbestanden.
- `maintenance.ps1`: Controleert en corrigeert bestandsnamen (kebab-case).
- `copy-images.ps1`: Slimme copy + sorteer/resize pipeline voor assets.

---
*Beheerd door Marco van Meurs*
