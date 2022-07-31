$credential = Get-Content -Path $PSScriptRoot\auth_token.txt
$device = Get-Content -Path $PSScriptRoot\hue_device_ip.txt
$api = "/api/$credential/scenes/"
$endpoint = "http://"+$device+$api
$scenes = Invoke-RestMethod -Method 'Get' -Uri $endpoint -TimeoutSec 5

# OUTPUT SCENES TO XML:
$scenes.PSObject.Properties | ForEach-Object {
    @{'SceneID' = $_.name; 'SceneGroup' = $_.value.group; 'SceneName' = $_.value.name}
} |  Export-Clixml $PSScriptRoot\hue_scenes.xml


exit
