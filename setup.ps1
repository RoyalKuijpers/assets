# ==========================================
# Script: Setup Kuijpers Assets Repository
# Auteur: Marco's Coding Assistant
# Doel: Mappenstructuur, gitignore en readme genereren
# ==========================================

$folders = @(
    "images",
    "images/logos",
    "images/other",
    "images/locations",
    "images/icons",
    "images/signs",
    "images/qr-codes",
    "templates",
    "templates/email",
    "templates/pdf",
    "templates/screenshots",
    "workflows",
    "workflows/schema",
    "docs",
    "docs/safety"
)

Write-Host "🚀 Starten met inrichten van repository..." -ForegroundColor Cyan

# 1. Mappen aanmaken
foreach ($folder in $folders) {
    if (-not (Test-Path $folder)) {
        New-Item -ItemType Directory -Path $folder | Out-Null
        Write-Host "✅ Map aangemaakt: $folder" -ForegroundColor Green
    } else {
        Write-Host "ℹ️ Map bestaat al: $folder" -ForegroundColor Yellow
    }
    
    # Git trackt geen lege mappen, dus we voegen een hidden placeholder toe
    $keepFile = "$folder/.gitkeep"
    if (-not (Test-Path $keepFile)) {
        New-Item -ItemType File -Path $keepFile -Value "" | Out-Null
    }
}

# 2. .gitignore genereren
$gitignoreContent = @"
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Windows Folder settings
Desktop.ini

# IDE settings (VS Code etc)
.vscode/
*.swp
*.swo

# Logs
*.log
"@

Set-Content -Path ".gitignore" -Value $gitignoreContent
Write-Host "✅ .gitignore aangemaakt/bijgewerkt" -ForegroundColor Green

# 3. README.md updaten
$readmeContent = @'
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

`https://royalkuijpers.github.io/kuijpers-assets/<pad>/<bestand>`

### Voorbeelden
- Logo: `https://royalkuijpers.github.io/kuijpers-assets/images/logos/kuijpers-logo.png`
- QR-code: `https://royalkuijpers.github.io/kuijpers-assets/images/qr-codes/QR-Pasaanvraag.png`
- Flow dashboard: `https://royalkuijpers.github.io/kuijpers-assets/KVA-QuickFlowLinker.html`

Let op: bestandsnamen met spaties of speciale tekens moeten URL-encoded worden (bijv. spatie → `%20`).

## 🛠️ Scripts

- `setup.ps1`: (Her)initialiseert mappenstructuur en basisbestanden.
- `maintenance.ps1`: Controleert en corrigeert bestandsnamen (kebab-case).
- `copy-images.ps1`: Slimme copy + sorteer/resize pipeline voor assets.

---
*Beheerd door Marco van Meurs*
'@

Set-Content -Path "README.md" -Value $readmeContent
Write-Host "✅ README.md bijgewerkt met instructies" -ForegroundColor Green

Write-Host "`n🎉 Klaar! Voer nu de volgende commando's uit in je terminal:" -ForegroundColor Cyan
Write-Host "   git add ." -ForegroundColor Gray
Write-Host "   git commit -m 'Structuur en documentatie update'" -ForegroundColor Gray
Write-Host "   git push" -ForegroundColor Gray
