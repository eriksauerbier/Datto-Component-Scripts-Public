# Datto Skript zum Aktualisieren von ADMX-Files inkl. Fehlerausgabe
# Stannek GmbH - v.1.2.1 - 14.06.2023 - E.Sauerbier

# Parameter
$UtilPath = "C:\Util"
$PDPath = "C:\Windows\PolicyDefinitions"
$CPDPath = "C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions"

# Name der ZIP-Datei auslesen
$Zip = Get-ChildItem -Filter *.zip

# Archiv entpacken 
Expand-Archive -Path $Zip.FullName -Force -Destination $Zip.DirectoryName

# Zu kopierende Dateien auslesen
$FilesADMX = Get-ChildItem -Path $($Zip.FullName.Replace('.zip','')) -Recurse -File -Include *.ADMX
$PathDEADML = Get-ChildItem -Path $($Zip.FullName.Replace('.zip','')) -Recurse -Directory -Include de-DE
$FilesDEADML = Get-ChildItem -Path $PathDEADML -Recurse -File
$PathENADML = Get-ChildItem -Path $($Zip.FullName.Replace('.zip','')) -Recurse -Directory -Include en-US
$FilesENADML = Get-ChildItem -Path $PathENADML -Recurse -File

# ADMX-Files in Standardpfad kopieren
foreach ($FileADMX1 in $FilesADMX) {Copy-Item -Path $FileADMX1.FullName -Destination $PDPath -Force -Verbose -ErrorVariable MoveError}
foreach ($FileDEADML1 in $FilesDEADML) {Copy-Item -Path $FileDEADML1.FullName -Destination "$PDPath\de-DE" -Force -Verbose -ErrorVariable MoveError}
foreach ($FileENADML1 in $FilesENADML) {Copy-Item -Path $FileENADML1.FullName -Destination "$PDPath\en-US" -Force -Verbose -ErrorVariable MoveError}

# Pruefen ob es einen CentralPolicy-Store gibt und auch ADMX-Files entsprechend kopieren
if (Test-Path $CPDPath) {
  foreach ($FileADMX2 in $FilesADMX) {Copy-Item -Path $FileADMX2.FullName -Destination $CPDPath -Force -Verbose -ErrorVariable MoveError}
  foreach ($FileDEADML2 in $FilesDEADML) {Copy-Item -Path $FileDEADML2.FullName -Destination "$CPDPath\de-DE" -Force -Verbose -ErrorVariable MoveError}
  foreach ($FileENADML2 in $FilesENADML) {Copy-Item -Path $FileENADML2.FullName -Destination "$CPDPath\en-US" -Force -Verbose -ErrorVariable MoveError}
  }

# Remove Archiv and expanded Archiv
Remove-Item -Path $($Zip.FullName.Replace('.zip','')) -Recurse -Force
Remove-Item -Path $Zip.FullName -Force

# inform the user
if ("" -eq $MoveError) {write-host "ADMX-Files has been updated"}
Else {Throw "There is a problem while moving: $MoveError"}