# Datto Skript zum installieren von Programme inkl. Fehlerausgabe
# Stannek GmbH - v.1.1 - 12.08.2022 - E.Sauerbier

# Hinweis:
# Für dieses Datto Skript müssen folgende Component Variablen gepflegt werden:
# Version     = Versionsnummer des Programms
# InstallFile = Name des angehängten Installations-Files
# ProgName = Name des zu installierenden Programms (Nur fürs Log)
# EXEargument = Isntallations Argumente für EXE-Installer, z.B. "/install /quiet /log $JobPath\$LogFile" 

# Parameter
$LogFile = "logfile.log"
$RunMethod = "runas" # Methode wie Start-Process ausgeführt werden soll (Default: open, Als Administrator: runas)

# Job-Verzeichnis ermitteln
$JobPath = Get-Location

# Installer-Typ ermitteln

$Filetype = $Env:InstallFile.Contains(".msi")

## Funktionen laden

# Funktion zum ermitteln von Installationsfehlern
function Get-ExitCode ($ExitCode) {
    switch ($ExitCode) {
        1603  {write-host "- Fehler: Die Installation hat den ExitCode 1603 ausgegeben";exit 1} 
        0     {write-host "- Installation erfolgreich."} 
        $null {write-host "- Installation erfolgreich."}
    }
}

##


# Prüfen um welchen Installationstyp es sich handelt

if ($Filetype -eq $True) {
    # MSI-Programm installieren oder aktualisieren
    Write-Host "$ENV:ProgName Version $ENV:Version wird aktualisiert"
    Start-Process -FilePath "msiexec.exe" -ArgumentList $("/i $JobPath\$env:InstallFile /quiet /norestart /l*v $JobPath\$LogFile") -verb $RunMethod -Wait -Verbose
    }
Else {
    # Exe-Programm installieren oder aktualisieren
    Write-Host "$ENV:ProgName Version $ENV:Version wird aktualisiert"
    Start-Process -FilePath "$JobPath\$env:InstallFile" -ArgumentList $Env:EXEargument -verb $RunMethod -Wait -Verbose
    }

# Installationsergebnis auslesen und bei Fehler abbrechen
Get-ExitCode = $LASTEXITCODE
write-host "$ENV:ProgName wurde erfolgreich um $(get-date) installiert"

# Job-Verzeichnis bereinigen
Remove-Item -Path $JobPath\* -Force -Recurse -Exclude $LogFile
write-host "========================================"
write-host "Installationsdateien wurden entfernt"