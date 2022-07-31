$credential = Get-Content -Path $PSScriptRoot\auth_token.txt
$device = Get-Content -Path $PSScriptRoot\hue_device_ip.txt
$api = "/api/$credential/groups/"
$endpoint = "http://"+$device+$api
$groups = Invoke-RestMethod -Method 'Get' -Uri $endpoint -TimeoutSec 5

$groups.PSObject.Properties | ForEach-Object {
    @{'GroupID' = $_.name; 'GroupName' = $_.value.name; 'GroupType' = $_.value.type}
} | Export-Clixml $PSScriptRoot\all_groups.xml

exit