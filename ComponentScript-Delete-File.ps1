# Datto Skript zum loeschen einer Datei
# Stannek GmbH - v.1.1 - 16.05.2023 - E.Sauerbier

write-host "Delete File $env:DelFile"
write-host "============================================="

# Check if File exist and delete it
If (Test-Path $env:DelFile) {Remove-Item -Path $env:DelFile -Force -Verbose}
Else {write-host "File not exist"}