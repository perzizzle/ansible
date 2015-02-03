param(
    [Parameter(Mandatory=$true,Position=0)] [string] $env,
    [Parameter(Mandatory=$true,Position=1)] [string] $name, 
    [Parameter(Mandatory=$true,Position=2)] [string] $job, 
    [Parameter(Mandatory=$true,Position=3)] [string] $build,
    [Parameter(Mandatory=$true,Position=4)] [string] $deploy,    
    [Parameter(Mandatory=$true,Position=5)] [bool] $stage,        
    [Parameter(Mandatory=$False,Position=6)] [string] $appname,    
	[Parameter(Mandatory=$False,Position=7)] [string[]] $artifacts,
    [Parameter(Mandatory=$false,Position=8)] [hashtable] $installArguments = @{})
	

$path = ("C:\!Surescripts\package\{0}\{1}\" -f $job, $build)


function Extract-ZipFile{
[cmdletbinding(DefaultParameterSetName="None")]
param(
        [parameter(Mandatory=$true)][string] $source,
        [parameter(Mandatory=$true)][string] $destination,
        [parameter(Mandatory=$false,ParameterSetName='exclude')][string] $exclude,
        [parameter(Mandatory=$false,ParameterSetName='include')][string] $include        
    )

    $psource = $source
    if($include){
        $psource = '{0}\{1}' -f $psource, $include
    }
    Write-Host ("Extract-ZipFile")
    Write-Host ("Extracting Zip File from {0} to {1}" -f $psource, $destination)	    
	$shell_app = new-object -com shell.application
	$sourceFolder = $shell_app.namespace($source)
	$destFolder = $shell_app.namespace($destination)
    $items = $sourceFolder.Items()    
    if($include){    
        $items = $sourceFolder.Items() | ?{$_.Name -eq $include}
    }
    elseif($exclude){    
        $items = $sourceFolder.Items() | ?{$_.Name -ne $exclude}
    }    

    $items | ?{ $_.IsFolder } | %{ $destFolder.CopyHere($_.GetFolder, 16) }
    $items | ?{ !$_.IsFolder } | %{ $destFolder.CopyHere($_, 16) }
    	
    Write-Host ('Extracting {0} complete.' -f $psource)

	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell_app) | Out-Null
}

Extract-ZipFile -source ("C:\!Surescripts\package\{0}\{1}\{2}" -f $job, $build, "deploy.zip") -destination ("C:\!Surescripts\package\{0}\{1}\" -f $job, $build)

Set-Location $path

. ('{0}\common\Surescripts.Utilities.ps1' -f $path)
. ('{0}\common\Surescripts.Certificate.ps1' -f $path)
. ('{0}\common\Surescripts.Domain.ps1' -f $path)
. ('{0}\common\Surescripts.Jenkins.ps1' -f $path)
. ('{0}\common\Surescripts.WebAdministration.ps1' -f $path)
. ('{0}\common\Surescripts.ServiceAdministration.ps1' -f $path)


Invoke-Expression '.\deploy.ps1 -env $env -name $name -job $job -build $build -deploy $deploy -stage $stage -appname $appname -artifacts $artifacts -installArguments $installArguments'