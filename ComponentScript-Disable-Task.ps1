# Datto Skript zum deaktivieren eines Tasks
# Stannek GmbH - v.1.0 - 07.11.2025 - E.Sauerbier

write-host "Disable Task $env:TaskName"
write-host "============================================="

# Taskinformation auslesen
try {$Task = Get-ScheduledTask -TaskName $env:TaskName -ErrorAction Stop}
catch {Throw "Task $env:TaskName not exist"}

# Task deakivieren falls aktiv
If ($Task.State -eq "Ready") {Disable-ScheduledTask -TaskPath $Task.TaskPath -TaskName $Task.TaskName -Verbose}
Else {Write-Host "WARNING: Task $env:TaskName is already disabled"}