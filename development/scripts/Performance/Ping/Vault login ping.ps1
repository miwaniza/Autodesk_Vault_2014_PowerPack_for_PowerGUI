Function global:VaultPingTest{
$elapsed = [System.Diagnostics.Stopwatch]::StartNew()
$total=0
$rep=5
	for ($t=1; $t -le $rep; $t++) {
		#Connecting dll
		Add-Type -Path "C:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.Connectivity.WebServices.dll"
		#Retreiving read-only credentials
		$cred = New-Object Autodesk.Connectivity.WebServicesTools.UserIdTicketCredentials($computer,$vault,$userID,$ticket)
		#Creating manager
		$elapsed.Start()
		$webSvc = New-Object Autodesk.Connectivity.WebServicesTools.WebServiceManager($cred)
		$elapsed.Stop()
		$total+=$elapsed.ElapsedMilliseconds
		$elapsed
		$elapsed.Reset()
		$webSvc.Dispose();
		sleep 1
	}
$avg=$total/$rep
#Note - update the -Count parameter below for how many ping requests you want to aggregate
$cur = [quest.powergui.hostfactory]::current.application.navigation.currentitem;
$ch = $cur.AddChild();
$cur.Expand();
$ch.Name = 'ping ' + $computer + ' ...';
$ch.Name = $computer;
$results;
$avgInt = ($avg -as [int] );
$avgNode=$ch.AddChild();
$avgNode.Name= "Avg=$avgInt ms";
$ch.Expand();
}


if ($g_login -eq $null)
	{Add-Type -Path "c:\Program Files (x86)\Autodesk\Autodesk Vault 2014 SDK\bin\Autodesk.DataManagement.Client.Framework.Vault.Forms.dll"
	$global:g_login=[Autodesk.DataManagement.Client.Framework.Vault.Forms.Library]::Login($null)
	}
$global:computer = $g_login.get_Server();
$global:vault = $g_login.get_Vault();
$global:userId = $g_login.get_UserID();
$global:ticket = $g_login.get_Ticket();
VaultPingTest