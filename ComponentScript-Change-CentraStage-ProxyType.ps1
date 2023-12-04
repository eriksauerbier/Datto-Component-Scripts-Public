# Datto Skript zum anpassen des ProxyTypes vom RMM-Agent
# Stannek GmbH - v.1.1.1 - 04.12.2023 - E.Sauerbier

#Parameter
$PathRMMConfig = Join-Path -Path $env:SystemDrive -ChildPath "Program Files (x86)\CentraStage\CagService.exe.config"

# XML-File einlesen
[XML]$FileXML = Get-Content -Path $PathRMMConfig

# ProxyType anpassen
$FileXML.configuration.applicationSettings.'CentraStage.Cag.Core.AppSettings'.SelectSingleNode("//setting[@name='ProxyType']").Value = "3"

# ProxyIP anpassen
$FileXML.configuration.applicationSettings.'CentraStage.Cag.Core.AppSettings'.SelectSingleNode("//setting[@name='ProxyIp']").Value = "win-proxy.services.datevnet.de"

# Proxy-Port anpassen
$FileXML.configuration.applicationSettings.'CentraStage.Cag.Core.AppSettings'.SelectSingleNode("//setting[@name='ProxyPort']").Value = "8880"

# angepasstes XML-File zurückschreiben
$FileXML.Save("$PathRMMConfig")