# Datto Skript zum kopieren einer Datei inkl. Fehlerausgabe
# Stannek GmbH - v.1.0.1 - 15.06.2023 - E.Sauerbier

write-host "Update File $env:FileName"
write-host "============================================="

# Update File if avail
if (test-path ($env:FilePath+"\"+$env:FileName)) {
  Move-Item -Path $env:FileName -Destination ($env:FilePath+"\"+$env:FileName) -Force -ErrorVariable MoveError
  # inform the user
  if ($MoveError.Count -eq "0") {write-host "- File has been updated"}
  Else {Throw "There is a problem while moving File: $MoveError"}
 }
Else {write-host "File wasn't in Destinationpath $env:FilePath"}