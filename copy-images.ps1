# ==========================================
# Script: SMART Copy & Clean Assets for GitHub
# Auteur: Marco's Coding Assistant
# Doel: Slimme synchronisatie, hash-checks, auto-sorteren in submappen
#       (logos, icons, locations) en opschonen bestandsnamen.
# Gebruik:
#   .\copy-images.ps1 -SourcePath "C:\Source" -DestinationPath "X:\Repo\images"
#   .\copy-images.ps1 -CleanTarget
#   .\copy-images.ps1 -DeleteWebP
# ==========================================

param (
    [string]$SourcePath = "D:\OD\OneDrive - Kuijpers\Afbeeldingen\Kuijpers Logos en Kleuren",
    [string]$DestinationPath = "X:\github\kuijpers-assets\images", # Let op: Base images folder
    [switch]$CleanTarget,
    [switch]$DeleteWebP
)

Add-Type -AssemblyName System.Drawing

# 1. Configuratie
$allowedExtensions = @(".png", ".jpg", ".jpeg", ".webp") 
$skipKeywords = @("voorbeeld", "sample", "test", "template", "draft", "kopie", "oud")
$targetWidths = @(600, 200) 

# Variabelen voor statistieken
$countSourceTotal = 0
$countDeleted = 0
$countUpdated = 0
$countSkipped = 0
$countResizeCreated = 0

# Check Directories
if (-not (Test-Path $SourcePath)) { Write-Warning "Bronmap niet gevonden: $SourcePath"; exit }
if (-not (Test-Path $DestinationPath)) { New-Item -ItemType Directory -Path $DestinationPath -Force | Out-Null }

# OPTIE 1: Doelmap leegmaken
if ($CleanTarget) {
    Write-Host "🧹 Doelmap leegmaken..." -ForegroundColor Yellow
    $items = Get-ChildItem "$DestinationPath\*" -Recurse -Force -ErrorAction SilentlyContinue
    $countDeleted = $items.Count
    Remove-Item "$DestinationPath\*" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "   -> $countDeleted items verwijderd." -ForegroundColor DarkGray
}

# OPTIE 2: WebP verwijderen
if ($DeleteWebP) {
    Write-Host "🗑️  WebP bestanden verwijderen uit doelmap..." -ForegroundColor Magenta
    $webpItems = Get-ChildItem -Path $DestinationPath -Filter "*.webp" -Recurse
    $countDeleted += $webpItems.Count
    if ($webpItems) {
        $webpItems | Remove-Item -Force
        Write-Host "   -> $($webpItems.Count) WebP bestanden verwijderd." -ForegroundColor DarkGray
    }
    
    # BELANGRIJK: Zorg dat we WebP ook niet meer kopiëren tijdens deze run
    $allowedExtensions = $allowedExtensions | Where-Object { $_ -ne ".webp" }
}

# Functie: Hash berekenen voor vergelijking
function Get-FileHashMD5 {
    param ($path)
    try {
        $stream = [System.IO.File]::OpenRead($path)
        $md5 = [System.Security.Cryptography.MD5]::Create()
        $hash = [BitConverter]::ToString($md5.ComputeHash($stream))
        $stream.Close()
        return $hash
    } catch { return $null }
}

# Functie: Resizen
function Resize-Image {
    param ($srcPath, $destPath, $maxWidth)
    try {
        $img = [System.Drawing.Image]::FromFile($srcPath)
        if ($img.Width -le $maxWidth) { $img.Dispose(); return $false }
        
        $ratio = $maxWidth / $img.Width
        $newHeight = [int]($img.Height * $ratio)
        $newImg = new-object System.Drawing.Bitmap $maxWidth, $newHeight
        $graph = [System.Drawing.Graphics]::FromImage($newImg)
        $graph.CompositingQuality = "HighQuality"
        $graph.InterpolationMode = "HighQualityBicubic"
        $graph.SmoothingMode = "HighQuality"
        
        $graph.DrawImage($img, 0, 0, $maxWidth, $newHeight)
        $newImg.Save($destPath, $img.RawFormat)
        
        $graph.Dispose(); $newImg.Dispose(); $img.Dispose()
        return $true
    } catch { return $false }
}

Write-Host "🚀 Starten met slimme synchronisatie en sorteren..." -ForegroundColor Cyan
Write-Host "   Bron: $SourcePath" -ForegroundColor DarkGray
Write-Host "   Doel: $DestinationPath" -ForegroundColor DarkGray

$files = Get-ChildItem -Path $SourcePath -File | Where-Object { $allowedExtensions -contains $_.Extension.ToLower() }
$countSourceTotal = $files.Count

foreach ($file in $files) {
    $lowerName = $file.Name.ToLower()
    
    # 1. Keyword Filter
    $shouldSkip = $false
    foreach ($key in $skipKeywords) {
        if ($lowerName -match $key) { $shouldSkip = $true; break }
    }
    if ($shouldSkip) { continue }

    # 2. Naam Schonen (Basis Kebab-case)
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($lowerName)
    $cleanName = $baseName -replace '[\s_]+', '-' -replace '[^a-z0-9\-]', '' -replace '\-{2,}', '-'
    
    # 3. Categorie Bepalen & Prefix Strippen
    $subFolder = "logos" # Default
    $finalNameBase = $cleanName

    if ($cleanName -match "favicon|icon|social|folder|button|knop") {
        $subFolder = "icons"
        # Strip prefixes zoals 'asset-', 'icon-', 'social-' omdat ze nu in de map 'icons' staan
        $finalNameBase = $cleanName -replace "^(asset-|icon-|social-|knop-)", ""
    }
    elseif ($cleanName -match "kaart|map|locatie|plattegrond|p3|6w|route|vestiging") {
        $subFolder = "locations"
        # Strip prefixes zoals 'asset-', 'locatie-', 'map-'
        $finalNameBase = $cleanName -replace "^(asset-|locatie-|map-|route-)", ""
    }
    else {
        $subFolder = "logos"
        # Strip 'asset-' prefix als het in logos staat, 'logo-' mag blijven of weg, jouw keus. 
        # Hier strippen we 'asset-' en laten we 'logo-' staan voor duidelijkheid, tenzij dubbel.
        $finalNameBase = $cleanName -replace "^asset-", ""
    }

    # Zorg dat submap bestaat
    $fullDestDir = Join-Path $DestinationPath $subFolder
    if (-not (Test-Path $fullDestDir)) { New-Item -ItemType Directory -Path $fullDestDir -Force | Out-Null }

    # Definitieve bestandsnaam + extensie
    $finalFileName = "$finalNameBase$($file.Extension.ToLower())"
    $destPath = Join-Path $fullDestDir $finalFileName
    $needsCopy = $false

    # 4. Hash Vergelijking
    if (Test-Path $destPath) {
        $srcHash = Get-FileHashMD5 -path $file.FullName
        $destHash = Get-FileHashMD5 -path $destPath
        
        if ($srcHash -ne $destHash) {
            Write-Host "⚡ Update ($subFolder): $finalFileName" -ForegroundColor Cyan
            $needsCopy = $true
        } else {
            $countSkipped++
        }
    } else {
        Write-Host "✅ Nieuw ($subFolder): $finalFileName" -ForegroundColor Green
        $needsCopy = $true
    }

    # 5. Kopiëren & Resizen
    if ($needsCopy) {
        Copy-Item -Path $file.FullName -Destination $destPath -Force
        $countUpdated++

        # Resizes (Skip WebP)
        if ($file.Extension.ToLower() -ne ".webp") {
            foreach ($width in $targetWidths) {
                $resizeName = "$finalNameBase-$($width)w$($file.Extension.ToLower())"
                $resizePath = Join-Path $fullDestDir $resizeName
                $didResize = Resize-Image -srcPath $file.FullName -destPath $resizePath -maxWidth $width
                if ($didResize) { $countResizeCreated++ }
            }
        }
    }
}

Write-Host "------------------------------------------------"
Write-Host "🏁 Klaar!" -ForegroundColor Cyan
Write-Host "   Bronbestanden:   $countSourceTotal" -ForegroundColor Gray
Write-Host "   Verwijderd:      $countDeleted" -ForegroundColor Red
Write-Host "   Geüpdatet/Nieuw: $countUpdated" -ForegroundColor Green
Write-Host "   Resizes gemaakt: $countResizeCreated" -ForegroundColor DarkGreen
Write-Host "   Ongewijzigd:     $countSkipped" -ForegroundColor Yellow
