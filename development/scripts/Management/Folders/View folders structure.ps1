  Function global:PrintFoldersInFolder {
  param ($parentFolder)
  # this is how you get the currently selected node
  $cur = [quest.powergui.hostfactory]::current.application.navigation.currentitem
  # AddChild function adds a subnode and gives you the object back so you can set the label and the code
 
 $folders = $g_login.FolderManager.GetChildFolders($parentFolder, $false, $false)
 
			foreach ( $folder in $folders)
				{
                    # recursively print the files in each sub-Folder
                    $ch = $cur.AddChild()
					$ch.Name = $folder.EntityName
					$global:tempFolder = $folder.Clone()
					$ch.Script = '$g_login.FolderManager.GetChildFolders($tempFolder, $false, $false)'
				}  
  
  # Set the code to be executed in case user clicks this new node
  # Return the object back so it gets into the grid as well 
  $folders
  
	}
# End Function global:Add-PowerGUIVaultuser


if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}


try {
$root = $g_login.FolderManager.RootFolder
PrintFoldersInFolder ($root)}
catch {
"error"
}