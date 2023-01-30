# Datto Skript zum bereitstellen einer Datei inkl. Fehlerausgabe
# Stannek GmbH - v.1.0 - 30.01.2023 - E.Sauerbier

write-host "Add-File $env:FileName"
write-host "============================================="

Move-Item -Path $env:FileName -Destination ($env:Filepath+"\"+$env:FileName) -Force -ErrorVariable MoveError
# inform the user
if ($MoveError.Count -eq "0") {write-host "- File has been added"}
Else {Throw "There is a problem while adding: $MoveError"}