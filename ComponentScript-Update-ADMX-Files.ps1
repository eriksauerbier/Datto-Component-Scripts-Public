# Datto Skript zum Aktualisieren von ADMX-Files inkl. Fehlerausgabe
# Stannek GmbH - v.1.1.1 - 19.05.2023 - E.Sauerbier

# Parameter
$UtilPath = "C:\Util"
$PDPath = "C:\Windows\PolicyDefinitions"
$CPDPath = "C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions"

# Name der ZIP-Datei auslesen
$Zip = Get-ChildItem -Filter $env:ZIPName

# Archiv entpacken 
Expand-Archive -Path $(".\"+$Zip) -DestinationPath $UtilPath -Force

# Zu kopierende Dateien auslesen
$files = Get-ChildItem -Path $($UtilPath+"\"+$Zip.Name.Replace('.zip','')) -Recurse -File

# ADMX-Files in Standardpfad kopieren
foreach ($file in $files) {Copy-Item -Path $file.FullName -Destination $(Join-Path -Path $PDPath -ChildPath $file.Directory.Name) -Force -Verbose -ErrorVariable MoveError}

# Pruefen ob es einen CentralPolicy-Store gibt und auch ADMX-Files entsprechend kopieren
if (Test-Path $CPDPath) {foreach ($file in $files) {Move-Item -Path $file.FullName -Destination $(Join-Path -Path $CPDPath -ChildPath $file.Directory.Name) -Force -Verbose -ErrorVariable MoveError}}

# Remove expanded Archiv
Remove-Item -Path $($UtilPath+"\"+$Zip.Name.Replace('.zip','')) -Recurse -Force

# inform the user
if ("" -eq $MoveError) {write-host "ADMX-Files has been updated"}
Else {Throw "There is a problem while moving: $MoveError"}