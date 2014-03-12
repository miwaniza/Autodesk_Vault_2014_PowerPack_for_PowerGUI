  Function global:PrintFoldersInFolder {
  param ( $parentFolderId)
  # this is how you get the currently selected node
  $cur = [quest.powergui.hostfactory]::current.application.navigation.currentitem
  # AddChild function adds a subnode and gives you the object back so you can set the label and the code
  $folders = $g_login.WebServiceManager.DocumentService.GetFoldersByParentId($parentFolderId, $false)

	foreach ( $folder in $folders)
		{
			$ch = $cur.AddChild()
			$ch.Name = $folder.Name
			$ch.Script = 'PrintFoldersInFolder('+$folder.Id+')'
			$files = $g_login.WebServiceManager.DocumentService.GetLatestFilesByFolderId($folder.Id, $false)
			$files
			$cur.Expand()	
		}   
}

if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}

try {
$root = $g_login.FolderManager.RootFolder

PrintFoldersInFolder ($root.Id)}
catch {
"error"
}