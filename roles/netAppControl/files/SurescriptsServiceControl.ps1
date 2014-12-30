Param(
	[Parameter(Mandatory=$True,Position=1)] [string] $cmd
)

$Services = Get-Service | Where-Object {$_.name -like "SSWinServices.*"}
foreach ($Service in $Services) {
	$name = $Service.name
	$status = $Service.status
	
	IF ($cmd -eq "START") {
		IF ($status -eq "STOPPED" ) {
			Write-Output "Start-Service $name"
			Start-Service $name
		}
		ELSE {
			Write-Output "Cannot start Service $name is $status"
		}
	} ELSEIF ($cmd -eq "STOP") {
		IF ($status -eq "RUNNING" ) {
			Write-Output "Stop-Service $name"
			Stop-Service $name
		}
		ELSE {
			Write-Output "Cannot stop Service $name is $status"
		}
	}  ELSEIF ($cmd -eq "RESTART") {
		IF ($status -eq "STOPPED" ) {
			Write-Output "Start-Service $name"
			Start-Service $name
		}
		ELSEIF ($status -eq "RUNNING" ) {
			Write-Output "Stop-Service $name"
			Stop-Service $name
			
			Write-Output "Start-Service $name"
			Start-Service $name
		}
	} ELSEIF ($cmd -eq "AUTO" -or $cmd -eq "AUTOMATIC") {
		Write-Output "Set Service $name to AUTOMATIC"
		Set-Service $name -startuptype AUTOMATIC
	} ELSEIF ($cmd -eq "MANUAL") {
		Set-Service $name -startuptype MANUAL
		Write-Output "Set Service $name to MANUAL"
	} ELSEIF ($cmd -eq "DISABLE" -or $cmd -eq "DISABLED") {
		#This will allow you to disable a running service
		Set-Service $name -startuptype DISABLED
		Write-Output "Set Service $name to DISABLED"
	}  ELSE {
		Write-Output "Unsupported command: $cmd"
	}
}