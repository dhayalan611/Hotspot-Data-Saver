# Hotspot Data Saver - monitor only; does not change services or metered state
$HotspotSSID = "YOUR_HOTSPOT_NAME"
$LogDirectory = "$env:LOCALAPPDATA\HotspotDataSaver"
$LogFile = Join-Path $LogDirectory "hotspot.log"
New-Item -Path $LogDirectory -ItemType Directory -Force | Out-Null
function Write-Log { param([string]$Message)
    Add-Content -Path $LogFile -Value "$(Get-Date -Format s) - $Message"
}
try {
    $profile = [Windows.Networking.Connectivity.NetworkInformation, Windows.Networking.Connectivity, ContentType=WindowsRuntime]::GetInternetConnectionProfile()
    if ($null -eq $profile) { Write-Log "No active internet connection."; exit 0 }
    $connection = $profile.WlanConnectionProfileDetails
    if ($null -eq $connection) { Write-Log "Active connection is not Wi-Fi."; exit 0 }
    $ssid = $connection.GetConnectedSsid()
    Write-Log "Connected Wi-Fi: $ssid"
    if ($ssid -eq $HotspotSSID) {
        $cost = $profile.GetConnectionCost()
        Write-Log "Hotspot connection cost: $($cost.NetworkCostType)"
    } else { Write-Log "Other Wi-Fi detected. No changes made." }
} catch { Write-Log "Error: $($_.Exception.Message)" }
