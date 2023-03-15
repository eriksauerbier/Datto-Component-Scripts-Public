# Datto Komponenten zum Suchen von installierten DATEV Programmen
# Stannek GmbH - v.1.0.1 - 14.03.2023 - E.Sauerbier

# Parameter
$PathProductlist='E:\WINDVSW1\DATEV\DATEN\INSTMAN\productlist\'
$SearchName = $ENV:SearchProgName

# Alle XML-Dateien in dem Pfad nehmen
$FilesProductlist=Get-ChildItem -Path $PathProductlist -Filter '*.xml'

# Installierte Produkte in Variable schreiben
$Products = Get-Content $FilesProductlist.FullName

# Nach Produkt suchen
If ($Products -like "*$SearchName*") {Throw "gesuchtes Programm bei $env:CustomerName vorhanden"}