# Datto Skript zum auslesen bestimmter Serverrollen und schreibt diese ein User-Defined-Field
# Stannek GmbH - v.1.1.1 - 15.02.2023 - E.Sauerbier

# Serverrollen in Variable schreiben
IF (Get-WindowsFeature AD-Domain-Services | Select-Object -ExpandProperty Installed) {$DeviceRole = "DC;"}
IF (Get-Service vmms -ErrorAction SilentlyContinue) {$DeviceRole += "Hyper-V Host;"}
IF (Get-WindowsFeature RDS-Connection-Broker | Select-Object -ExpandProperty Installed) {$DeviceRole += "RD-Sessionbroker;"}
IF (Get-WindowsFeature RDS-Licensing | Select-Object -ExpandProperty Installed) {$DeviceRole += "RD-Licenseserver;"}
IF (Get-WindowsFeature RDS-RD-Server| Select-Object -ExpandProperty Installed) {$DeviceRole += "RD-SessionHost;"}
IF (Test-Path $("\\"+$env:COMPUTERNAME+"\WINDVSW1")) {$DeviceRole += "DATEV-FS;"}
IF (Get-Service IpPbxSrv -ErrorAction SilentlyContinue) {$DeviceRole += "Swyx-Server;"}
IF (Get-Service MSExchangeIS -ErrorAction SilentlyContinue) {$DeviceRole += "Exchange-Server;"}
IF (Get-Service VeeamBackupSvc -ErrorAction SilentlyContinue) {$DeviceRole += "Veeam-Backupserver;"}
IF (Get-Service VeeamEndpointBackupSvc -ErrorAction SilentlyContinue) {$DeviceRole += "Veeam-Agent;"}

# Mitgegebenes UDF ermitteln und Wert schreiben
Write-Host "UDF Wert aktualisert"
Write-Host $DeviceRole
$Customfield = "Custom"+$env:UDFNumber
New-ItemProperty -Path "HKLM:\SOFTWARE\CentraStage" -Name $Customfield -PropertyType string -Value $DeviceRole -Force