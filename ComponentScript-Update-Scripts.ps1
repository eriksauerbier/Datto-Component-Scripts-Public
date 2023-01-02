# Datto Skript zum kopieren von Skripten inkl. Fehlerausgabe
# Stannek GmbH - v.1.0 - 28.11.2022 - E.Sauerbier


write-host "Update Script $env:ScriptName"
write-host "============================================="

# Update Script if avail
if (test-path ($env:Scriptpath+"\"+$env:ScriptName)) {
  Move-Item -Path $env:ScriptName -Destination ($env:Scriptpath+"\"+$env:ScriptName) -Force -ErrorVariable MoveError
  # inform the user
  if ($MoveError -eq $Null) {write-host "- Script has been updated"}
  Else {write-host "There is a problem while moving: $MoveError"}
 }
Else {write-host "Script wasn't in Destinationpath $env:Scriptpath"}