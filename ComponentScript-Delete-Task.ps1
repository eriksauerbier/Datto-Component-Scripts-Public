# Datto Skript zum loeschen eines Tasks
# Stannek GmbH - v.1.0 - 03.07.2023 - E.Sauerbier

write-host "Delete Task $env:TaskName"
write-host "============================================="

# Check if Task exist and delete it
 If ((Get-ScheduledTask -TaskName $env:TaskName -ErrorAction SilentlyContinue).TaskName -eq $env:TaskName) {Unregister-ScheduledTask -TaskName $env:TaskName -Confirm:$false }
Else {Throw "Task $env:TaskName not exist"}