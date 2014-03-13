  Function global:PrintFoldersInFolder{
  param ($cur, $parentpath)
  $childs=$cur.Childs
	Write-Host $parentpath
  foreach($children in $childs){
	if($children.Name -ne $null -and $children.Childs -ne $null){$path1=$parentpath+"\"+$children.Name; New-Item -ItemType Directory -Force -Path $path1}
	$filename=$path1+"\"+$children.name+".ps1"
	if($children.script.script -ne $null){$children.script.script | Out-File -FilePath $filename}
	PrintFoldersInFolder $children $path1
	}
}

 $start = [quest.powergui.hostfactory]::current.application.navigation.currentitem;
 $root="d:\temp1\upload"
 Write-Host $root
 PrintFoldersInFolder $start $root