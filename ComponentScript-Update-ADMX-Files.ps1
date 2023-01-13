# Datto Skript zum Aktualisieren von ADMX-Files inkl. Fehlerausgabe
# Stannek GmbH - v.1.0.4 - 13.01.2023 - E.Sauerbier

# Parameter
$UtilPath = "C:\Util"
$PDPath = "C:\Windows\PolicyDefinitions"
$CPDPath = "C:\Windows\SYSVOL\domain\Policies\PolicyDefinitions"

# Name der ZIP-Datei auslesen
$Zip = Get-ChildItem -Filter $env:ZIPName

# Archiv entpacken 
Expand-Archive -Path $(".\"+$Zip) -DestinationPath $UtilPath -Force

# ADMX-Files kopieren
Move-Item -Path $($UtilPath+"\"+$Zip.Name.Replace('.zip','')+"\*.*") -Destination $PDPath -Force -ErrorVariable MoveError

# Pruefen ob es einen CentralPolicy-Store gibt und ADMX-Files entsprechend kopieren 
if (Test-Path $CPDPath) {Move-Item -Path $($UtilPath+"\"+$Zip.Name.Replace('.zip','')+"\*.*") -Destination $CPDPath -Force -ErrorVariable MoveError}

# Remove expanded Archiv
Remove-Item -Path $($UtilPath+"\"+$Zip.Name.Replace('.zip','')) -Recurse -Force

# inform the user
if ("" -eq $MoveError) {write-host "Script has been updated"}
Else {Throw "There is a problem while moving: $MoveError"}