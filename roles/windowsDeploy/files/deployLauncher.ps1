param(
    [Parameter(Mandatory=$true,Position=0)][string] $env,                        
    [Parameter(Mandatory=$true,Position=1)][string] $name,         
    [Parameter(Mandatory=$true,Position=2)][string] $job, 
    [Parameter(Mandatory=$false,Position=3)][string] $build = 'LAST',    
    [Parameter(Mandatory=$false,Position=4)][string] $deploy = 'LAST',          
    [Parameter(Mandatory=$false,Position=5)][string] $appname, 
    [Parameter(Mandatory=$true,Position=6)][string[]] $artifacts,
    [Parameter(Mandatory=$false,Position=7)][hashtable] $installArguments = @{},	 
    [Parameter(Mandatory=$true,Position=8)] [bool] $stage
)
#./testLauncher  -env Local -server serverName -appName Name -artifacts artifacts.zip -installArguments @{key='value'} -deployNumber 123 -switch

Write-Output "Env: $env Name: $name Repository/Job: $job Build: $build Deploy: $deploy AppName: $appName Artifacts: $artifacts InstallArguments: $installArguments Stage: $stage"
