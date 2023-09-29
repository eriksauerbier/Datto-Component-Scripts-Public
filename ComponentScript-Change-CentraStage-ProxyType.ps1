# Datto Skript zum anpassen des ProxyTypes vom RMM-Agent
# Stannek GmbH - v.1.0 - 28.09.2022 - E.Sauerbier

#Parameter
$PathRMMConfig = Join-Path -Path $env:SystemDrive -ChildPath "Program Files (x86)\CentraStage\CagService.exe.config"

# XML-File einlesen
[XML]$FileXML = Get-Content -Path $PathRMMConfig

# ProxyType anpassen
$FileXML.configuration.applicationSettings.'CentraStage.Cag.Core.AppSettings'.SelectSingleNode("//setting[@name='ProxyType']").Value = "0"

# angepasstes XML-File zurückschreiben
$FileXML.Save("$PathRMMConfig")