#If device is battery powered makes sure it is charging
$BatteryStatus = Get-CimInstance -ClassName Win32_Battery
if($BatteryStatus){
    if($BatteryStatus.BatteryStatus = 1 -and $BatteryStatus.EstimatedChargeRemaining -lt 35){
        Write-host '<-Start Result->'
        Write-Host "STATUS=Device low on power and is not charging"
        Write-host '<-End Result->'
        exit 1
    }
}

#Checks if LSUClient is installed an installs if not
if(!(Get-Module -Name "LSUClient"){
    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Install-Module -Name 'LSUClient' -Force
    Import-Module 'LSUClient'
}

#Checking and installing updates
if($env:mode -eq "Silent"){
    $updates = Get-LSUpdate | Where-Object { $_.Installer.Unattended }
    $updates | Save-LSUpdate -Verbose
    $updates | Install-LSUpdate -Verbose
    Write-host '<-Start Result->'
    Write-Host "STATUS=Updates have finished"
    Write-host '<-End Result->'
    exit 0
} else {
    $updates = Get-LSUpdate
    $updates | Install-LSUpdate -Verbose
    Write-host '<-Start Result->'
    Write-Host "STATUS=Updates have finished"
    Write-host '<-End Result->'
    exit 0
}