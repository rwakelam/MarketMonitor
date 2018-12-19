$roundhouse_exe_path = ".\rh.exe"
$scripts_dir = ".\Scripts"
$version_file = ".\MarketMonitor.Database.dll"
$db_server = "localhost"
$db_name = "MarketMonitor"
$env= "LOCAL"

Write-Host "RoundhousE is going to run on server: "$db_server
Write-Host "RoundhousE is going to run on database: "$db_name
Write-Host "Executing RoundhousE for environment:" $env

&$roundhouse_exe_path -s $db_server -d $db_name -f $scripts_dir --env $env --vf $version_file --silent --transaction --ra=any
