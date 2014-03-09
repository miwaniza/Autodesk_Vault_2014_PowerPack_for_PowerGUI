param(
[string] $entityClassId,
[string] $systemName,
[string] $displayName,
[Drawing.Color] $color,
[string] $description,
[Autodesk.Connectivity.WebServices.BehaviorAssignmentType] $assignmentType

)

if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}
$g_login.WebServiceManager.CategoryService.AddCategory( $entityClassId,$systemName,$displayName,$color,$description,$assignmentType)