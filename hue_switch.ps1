# INPUT PARAMETERS:
param(
    $groupname,
    $scenename
)

# IMPORT REFS:
Write-Host "Importing groups and scenes"
$groups = Import-Clixml $PSScriptRoot\hue_groups.XML
$scenes = Import-Clixml $PSScriptRoot\hue_scenes.xml

# GET GROUP ID FROM GROUP NAME:
Write-Host "Getting Group ID for:"$groupname
$groups = $groups | Where-Object {$_.GroupType -eq 'Room'}
$groups = $groups | Where-Object {$_.GroupName -eq $groupname}
$grpid = $groups.GroupID
Write-Host "Group"$groupname"has ID"$grpid

# SCENE ID FROM SCENE NAME:
Write-Host "Getting Scene ID for:"$scenename
$scenes = $scenes | where-object {$_.SceneGroup -eq $grpid}
$scnobj = $scenes | Where-Object {$_.SceneName -eq $scenename}
$scnid = $scnobj.SceneID
Write-Host "Scene"$scenename"has ID"$scnid

Write-Host "Switching to scene:"$scenename

# CONNECTION INFO:
Write-Host "Setting variables"
$credential = Get-Content -Path $PSScriptRoot\hue_auth_token.txt
$device = Get-Content -Path $PSScriptRoot\hue_device_ip.txt

# API TO USE:
$api = "/api/$credential/groups/0/action/"

# SEND TO DEVICE:
$payload = @{
    scene = $scnid
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