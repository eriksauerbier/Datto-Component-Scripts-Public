# Datto Monitoring-Skript zum Abfragen von vorhandenen Snaptshot auf einem Hyper-V Host
# Stannek GmbH - v.1.0 - 04.12.2023 - E.Sauerbier

# Parameter
$DaysToWarn = "1"

# Snapshot auslesen
$SnapShots = Get-VM | Get-VMSnapshot | Select-Object VMName,Name,SnapshotType,CreationTime,ComputerName

# Checken ob Snapshots vorhanden sind und ob diese aelter als x-Tage sind
If ($SnapShots.VMName.Count -eq "0") {Write-Host "Keine Snapshots vorhanden";Exit 1}
Elseif ($SnapShots.CreationTime -le $(Get-Date).AddDays(-$DaysToWarn)) {Write-RRMAlert "Folgende VMs haben Snapshots $SnapShots.VMName die aelter als $DaysToWarn Tage sind"}
Else {Write-Host "Snapshots von $($SnapShots.VMName) vorhanden aber noch im Zeitlichen Rahmen";Exit 1}