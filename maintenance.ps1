# ==========================================
# Script: Maintenance & Fix Filenames
# Auteur: Marco's Coding Assistant
# Doel: Scant en repareert bestandsnamen naar 'kebab-case'
# Gebruik: 
#   .\maintenance.ps1        (Alleen rapporteren)
#   .\maintenance.ps1 -Fix   (Daadwerkelijk hernoemen)
# ==========================================

param (
    [switch]$Fix
)

# Mappen om te scannen (voeg toe indien nodig)
$targetFolders = @("images", "docs", "templates")

# Regex voor toegestane bestandsnamen: 
# a-z (kleine letters), 0-9, - (koppelteken), . (punt voor extensie)
$validPattern = '^[a-z0-9\-]+\.[a-z0-9]+$'

Write-Host "🔍 Starten met scannen van assets..." -ForegroundColor Cyan
if ($Fix) { Write-Host "⚠️  FIX MODE ACTIEF: Bestanden worden hernoemd." -ForegroundColor Yellow }

$issuesFound = 0

foreach ($folder in $targetFolders) {
    if (Test-Path $folder) {
        # Recursief bestanden ophalen
        $files = Get-ChildItem -Path $folder -Recurse -File

        foreach ($file in $files) {
            $oldName = $file.Name
            
            # 1. Alles naar kleine letters
            $newName = $oldName.ToLower()
            
            # 2. Vervang spaties en underscores door koppeltekens
            $newName = $newName -replace '[\s_]+', '-'
            
            # 3. Verwijder vreemde tekens (haakjes, etc), behoud letters, cijfers, -, .
            $newName = $newName -replace '[^a-z0-9\-\.]', ''
            
            # 4. Verwijder dubbele koppeltekens (bijv. "file--name.png")
            $newName = $newName -replace '\-{2,}', '-'

            # Check of de naam veranderd is OF niet aan de regex voldoet
            if ($oldName -cne $newName -or $newName -notmatch $validPattern) {
                $issuesFound++
                $fullPath = $file.FullName
                $newPath = Join-Path $file.DirectoryName $newName

                if ($oldName -ne $newName) {
                    Write-Host "❌ Fout: $oldName" -ForegroundColor Red -NoNewline
                    Write-Host " -> $newName" -ForegroundColor Green
                    
                    if ($Fix) {
                        # Check collision
                        if (Test-Path $newPath) {
                            Write-Host "   ⛔ Skipped: Doelbestand bestaat al ($newName)" -ForegroundColor Magenta
                        } else {
                            # Rename actie
                            try {
                                Rename-Item -Path $fullPath -NewName $newName -ErrorAction Stop
                                Write-Host "   ✅ Hernoemd" -ForegroundColor Green
                            } catch {
                                Write-Host "   💥 Error bij hernoemen: $_" -ForegroundColor Red
                            }
                        }
                    }
                } elseif ($newName -notmatch $validPattern) {
                    # Als naam 'schoon' lijkt maar toch niet matcht (bv beginnend met -)
                    Write-Host "⚠️  Warning: $oldName (Voldoet niet aan strict pattern)" -ForegroundColor Yellow
                }
            }
        }
    }
}

Write-Host "------------------------------------------------"
if ($issuesFound -eq 0) {
    Write-Host "✅ Alles ziet er strak uit! Geen problemen gevonden." -ForegroundColor Green
} else {
    if (-not $Fix) {
        Write-Host "⚠️  $issuesFound bestanden gevonden die niet voldoen." -ForegroundColor Yellow
        Write-Host "💡 Draai '.\maintenance.ps1 -Fix' om ze automatisch te herstellen." -ForegroundColor Cyan
    } else {
        Write-Host "🏁 Klaar. $issuesFound bestanden verwerkt." -ForegroundColor Cyan
    }
}