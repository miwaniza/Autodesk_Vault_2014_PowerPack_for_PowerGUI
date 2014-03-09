Function global:GetUSDRates{
$xml = New-Object xml
$xml.Load('http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml')
$date=$xml.Envelope.Cube.Cube.time
$rates = $xml.Envelope.Cube.Cube.Cube
$usd = $rates | Where-Object { $_.currency -eq 'USD' } | 
Select-Object -ExpandProperty rate

	$ceDef=$g_login.WebServiceManager.CustomEntityService.GetAllCustomEntityDefinitions() | Where-Object{$_.DispName -eq $cEntityDefinition}
	if(!$ceDef)	{"Create _"+$cEntityDefinition+"_ custom object definition";Break}
	
$Ce=$g_login.WebServiceManager.CustomEntityService.AddCustomEntity($ceDef.Id, $date)
$CeDescr = $g_login.WebServiceManager.PropertyService.GetPropertyDefinitionInfosByEntityClassId("CUSTENT",$null) | Where-Object{$_.PropDef.DispName -eq $CeDescrName}
$CeValue = $g_login.WebServiceManager.PropertyService.GetPropertyDefinitionInfosByEntityClassId("CUSTENT",$null) | Where-Object{$_.PropDef.DispName -eq $CeValueName}
if(!$CeDescr)	{"Create _"+$CeDescrName+"_ property definition";Break}
if(!$CeValue)	{"Create _"+$CeValueName+"_ property definition";Break}
$g_login.WebServiceManager.CustomEntityService.UpdateCustomEntityProperties($Ce.Id,$ceDescr.PropDef.Id,"EUR-USD")
$g_login.WebServiceManager.CustomEntityService.UpdateCustomEntityProperties($Ce.Id,$ceValue.PropDef.Id,$usd)
}

$cEntityDefinition = "Exchange rate"
$CeDescrName="Decription"
$CeValueName="Value"
if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}
GetUSDRates