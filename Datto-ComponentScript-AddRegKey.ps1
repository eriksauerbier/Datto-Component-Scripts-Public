# Datto Skript zum setzen von REG-Keys
# Stannek GmbH - v.1.0 - 12.08.2022 - E.Sauerbier

# Hinweis:
# Für dieses Datto Skript müssen folgende Component Variablen gepflegt werden:
# ProgName = Name des zu installierenden Programms (Nur fürs Log)

# Parameter
$RegPath1 = "HKLM:\SOFTWARE\Test"
$RegPath2 = "HKCU:\SOFTWARE\Test"

# Muster
# New-ItemProperty -Type DWord -Path $RegPath1 -Name Temp -value "1" -Force
# New-ItemProperty -Type String -Path $RegPath2 -Name Temp -value "Test" -Force

# REG-Keys setzen
Write-Host "REG-Key(s) für $Env:ProgName wird gesetzt"

New-ItemProperty -Type DWord -Path $RegPath1 -Name 
