$storageDir = $env:TEMP
$webclient = New-Object System.Net.WebClient
$url = "http://powergui.org/servlet/KbServlet/download/4131-102-6870/Autodesk%20Vault%202014%20Powerpack%20Readme.pdf"
$file = "$storageDir\Autodesk Vault 2014 Powerpack Readme.pdf"
$webclient.DownloadFile($url,$file)

Invoke-Item $file
