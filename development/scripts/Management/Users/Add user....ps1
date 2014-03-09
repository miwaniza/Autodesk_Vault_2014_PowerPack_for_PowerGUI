param(
	[string]$userName,
	[string]$password,
    [Autodesk.Connectivity.WebServices.AuthTyp]$atype,
	[string]$firstName,
	[string]$lastName,
	[string]$email,
	[bool]$isActive,
	[long[]]$roleIdArray,
	[long[]]$vaultIdArray
)

if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}
$g_login.WebServiceManager.AdminService.AddUser($userName,$password,$atype,$firstName,$lastName,$email,$isActive,$roleIdArray,$vaultIdArray)