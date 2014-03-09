 Function global:Add-PowerGUIVaultUser {
  param ($obj)
  # this is how you get the currently selected node
  $cur = [quest.powergui.hostfactory]::current.application.navigation.currentitem;
  # AddChild function adds a subnode and gives you the object back so you can set the label and the code
  $ch = $cur.AddChild()
 
  # Set the label
  $ch.Name = $_.Name
  #$ch | Add-Member -Name Id -MemberType NoteProperty -Value $_.ID
  # Set the code to be executed in case user clicks this new node
  $ch.Script = '$g_login.WebServiceManager.AdminService.GetPermissionsByUserId('+$_.Id+')'
  
  # Return the object back so it gets into the grid as well 
  $_
	}
# End Function global:Add-PowerGUIVaultuser
if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}

$g_login.WebServiceManager.AdminService.GetAllusers() | foreach {Add-PowerGUIVaultUser $_}