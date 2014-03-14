  Function global:PrintFoldersInFolder{
  param ($cur, $parentpath)
  $path1=$parentpath
  $childs=$cur.Childs
  foreach($children in $childs){
	if($children.Childs -ne $null)
		{$path1=$parentpath+"\"+$children.Name;
		New-Item -ItemType Directory -Force -Path $path1
		}
	$filename=$path1+"\"+$children.name+".ps1"
	$filename
	if($children.script.script -ne $null)
		{$children.script.script | Out-File -FilePath $filename}
	PrintFoldersInFolder $children $path1
	}
}

 $start = [quest.powergui.hostfactory]::current.application.navigation.currentitem;
 $start1=$start.parent.parent
 $global:exportRoot=$(Read-Host "Enter export path")
 PrintFoldersInFolder $start1 $exportRoot
