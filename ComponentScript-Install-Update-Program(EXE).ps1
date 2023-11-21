# Skript zum installieren/aktualisieren von Programmen mit EXE-Installern ohne Benutzereingabe
# Stannek GmbH - Version 1.0 - 13.11.2023 ES

# Funktionen laden
function Get-ExitCode ($ExitCode) {
    switch ($ExitCode) {
        0     {write-host "Installation erfolgreich. Exitcode: $ExitCode"} 
        $null {write-host "Installation fehlgeschlagen, Exitcode: null"}
        default {Write-Host "Installation fehlgeschlagen, Exitcode: $ExitCode"}
    }
}

# Name des Installers auslesen
$NameInstaller = Get-ChildItem -Filter *.exe

# checken ob die Anwendung gestartet ist und wenn ja Skript beenden
try {get-process -Name $env:NameProcess -ErrorAction Stop}
catch {Throw "Anwendung $env:NameProcess gestartet, Update wird abgebrochen"}

# Anwendung installieren
$ProcessInstall = (Start-Process -FilePath $NameInstaller.FullName -ArgumentList $env:ArgumentsInstaller -Wait -PassThru)
# Wait Parameter wird von der Exe anscheinend ignoriert, daher 10 Sekunden warten. 
Start-Sleep -Seconds 10

Get-ExitCode $ProcessInstall.ExitCode