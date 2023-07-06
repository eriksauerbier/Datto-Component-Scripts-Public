# Datto Skript zum loeschen eines lokalen Users
# Stannek GmbH - v.1.0 - 06.07.2023 - E.Sauerbier

write-host "Delete USer $env:DelUserName"
write-host "============================================="


If ((Get-LocalUser -Name $env:DelUserName -ErrorAction SilentlyContinue).Name -ne $Null) {Remove-LocalUser -Name $env:DelUserName -Confirm:$false} 
Else {Throw "User $($env:DelUserName) nicht vorhanden"}