# Datto Skript zum deinstallieren von Programme
# Stannek GmbH - v.1.0 - 12.08.2022 - E.Sauerbier

# Hinweis:
# Für dieses Datto Skript müssen folgende Component Variablen gepflegt werden:
# ProgName = Name des zu installierenden Programms (Nur fürs Log)

# Programm auslesen und deinstallieren
Write-Host "$Env:ProgName wird deinstalliert"
$UnInstall = Get-WmiObject -Class Win32_Product -ErrorAction Stop | Where-Object {$_.Name -match "$Env:ProgName"}
$UnInstall.Uninstall()
