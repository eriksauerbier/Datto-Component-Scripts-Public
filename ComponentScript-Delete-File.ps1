# Datto Skript zum löschen einer Datei
# Stannek GmbH - v.1.0 - 17.02.2023 - E.Sauerbier

write-host "Delete File $env:DelFile"
write-host "============================================="

# Delete File

Remove-Item -Path $env:DelFile -Force -Verbose