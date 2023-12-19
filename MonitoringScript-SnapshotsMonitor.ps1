# Datto Monitoring-Skript zum Abfragen von vorhandenen Snaptshot auf einem Hyper-V Host
# Stannek GmbH - v.1.1 - 19.12.2023 - E.Sauerbier

# Parameter
$DaysToWarn = "1"

# Funktionen laden
function Write-RMMDiag ($messages) {
    write-host '<-Start Diagnostic->'
    foreach ($Message in $Messages) { $Message }
    write-host '<-End Diagnostic->'
    } 
function Write-RMMAlert ($message) {
    write-host '<-Start Result->'
    write-host "R=$message"
    write-host '<-End Result->'
} 

# Snapshot auslesen
$SnapShots = Get-VM | Get-VMSnapshot | Select-Object VMName,Name,SnapshotType,CreationTime,ComputerName

# Checken ob Snapshots vorhanden sind und ob diese aelter als x-Tage sind
If ($SnapShots.VMName.Count -eq "0") {Write-RMMAlert "Keine Snapshots vorhanden";Exit 0}
Elseif ($SnapShots.CreationTime -le $(Get-Date).AddDays(-$DaysToWarn)) {Write-RMMAlert "Folgende VMs haben Snapshots $($SnapShots.VMName) die aelter als $DaysToWarn Tage sind";Exit 1}
Else {Write-RMMAlert "Snapshots von $($SnapShots.VMName) vorhanden aber noch im Zeitlichen Rahmen";Exit 0}