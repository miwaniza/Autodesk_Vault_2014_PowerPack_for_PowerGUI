Function global:VaultPingTest{
#Note - update the -Count parameter below for how many ping requests you want to aggregate
$cur = [quest.powergui.hostfactory]::current.application.navigation.currentitem;
$ch = $cur.AddChild();
$cur.Expand();
$ch.Name = 'ping ' + $computer + ' ...';
$results = Test-Connection -ComputerName $computer -Count 4;
$ch.Name = $computer;
$results;
$avg = ($results | Measure-Object ResponseTime -Average).Average;
$max = ($results | Measure-Object ResponseTime -Maximum).Maximum;
$avgInt = ($avg -as [int] );
$maxInt = ($max -as [int] );
$avgNode=$ch.AddChild();
$maxNode=$ch.AddChild();
$avgNode.Name= "Avg=$avgInt ms";
$maxNode.Name= "Max=$maxInt ms";
$ch.Expand();
}


if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}
$global:computer = $g_login.get_Server();
VaultPingTest