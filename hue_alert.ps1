# INPUT PARAMETERS:
param(
    $groupname
)

# IMPORT REFS:
Write-Host "Importing groups"
$groups = Import-Clixml $PSScriptRoot\hue_groups.XML

# GET GROUP ID FROM GROUP NAME:
Write-Host "Getting Group ID for:"$groupname
$groups = $groups | Where-Object {$_.GroupType -eq 'Room'}
$groups = $groups | Where-Object {$_.GroupName -eq $groupname}
$grpid = $groups.GroupID
Write-Host "Group"$groupname"has ID"$grpid

# CONNECTION INFO:
Write-Host "Setting variables"
$credential = Get-Content -Path $PSScriptRoot\hue_auth_token.txt
$device = Get-Content -Path $PSScriptRoot\hue_device_ip.txt

# API TO USE:
$api = "/api/$credential/groups/$grpid/action/"

# SEND TO DEVICE:
$payload = @{
    alert = 'lselect'
}
Write-Host "Converting payload"
$json = ConvertTo-Json $payload 

$endpoint = "http://"+$device+$api

Write-Host "Sending payload"
$endpoint
$json
Invoke-RestMethod -Method 'Put' -Uri $endpoint -Body $json -TimeoutSec 5
Write-Host "Payload sent"

exit