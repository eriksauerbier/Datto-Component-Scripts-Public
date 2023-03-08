# Datto Skript zum aktualisieren einer GPO
# Stannek GmbH - Version 1.0.2 - 30.01.2023 ES

# Skript abbrechen, wenn Admin-Policy nicht vorhanden
If (!(Get-GPO -Name $env:GPOName)) {Throw "$env:GPOName nicht vorhanden"}

# Name der ZIP-Datei auslesen
$ComponentZip = Get-ChildItem -Filter *.zip

# Archiv entpacken und passend kopieren
Expand-Archive -Path $ComponentZip.FullName -DestinationPath $ComponentZip.DirectoryName -Force

# Pfad des entpackten Archives ermitteln
$ComponentFolder = $($ComponentZip.FullName.Replace('.zip',''))

# Aktuelle GPO-Vorlage importieren
[xml]$BackupID = Get-Content $($ComponentFolder+"\Manifest.xml")
[String]$BackupID = $BackupID.Backups.BackupInst.ID.'#cdata-section'
Import-GPO -BackupId $BackupID -Path $ComponentFolder -TargetName $env:GPOName