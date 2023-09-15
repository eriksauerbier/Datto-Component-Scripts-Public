# Datto Skript zum emtfernen des Autologon Passworts im LSA-Speicher
# Stannek GmbH - v.1.0 - 29.08.2023 - E.Sauerbier

.\PsExec64.exe -accepteula -i -s powershell -command "Remove-Item -Path HKLM:\Security\Policy\Secrets\DefaultPassword\ -r -Force"