# INPUT PARAMETERS:
$device = Read-Host -Prompt "What is the IP address of your Hue bridge?"

# PROMPT FOR AUTH:
Read-Host -Prompt "Press the button on the Hue bridge ($device), then press Enter to continue."

# CREATE LOGIN
$endpoint = "http://"+$device+"/api"

$payload = @{
    devicetype = 'aerowavePSHNL'
}

$json = ConvertTo-Json $payload

$login = Invoke-RestMethod -Method 'Post' -Uri $endpoint -Body $json

# CHECK RESPONSE AND RETURN ERROR OR SAVE TOKEN AND IP:
if ($login.error.description -ne $null) {
    Read-Host -Prompt "Error: $($login.error.description) - Press Enter to quit."
    exit
}
elseif ($login.success.username -ne $null) {
    $login.success.username  | Out-File ${PSScriptRoot}\hue_auth_token.txt
    $device | Out-File ${PSScriptRoot}\hue_device_ip.txt
    Read-Host -Prompt "Success! Press Enter to finish."
}

exit