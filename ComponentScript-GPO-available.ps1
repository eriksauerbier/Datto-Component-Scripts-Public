# Skript zum auslesen einer gesuchten GPO
# Stannek GmbH - v.1.0 - E.Sauerbier

try {get-gpo -Name $Env:NameGPO -ErrorAction Stop} 
Catch {Throw "GPO $($Env:NameGPO) Nicht vorhanden"}