# LCA Metadata
# Delay: 5 seconds
# Blocking: yes

# =========================
# VM Life Cycle Action (PowerShell)
# Disable Windows Update
# =========================

Write-Host "Starting Windows Update Disable Script..." -ForegroundColor Cyan

# --- logging ---
$logDir = "C:\logs"
if (-not (Test-Path $logDir)) { 
    New-Item -ItemType Directory -Path $logDir | Out-Null 
}
$logFile = Join-Path $logDir "disable-windows-update_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Log {
    param([string]$m)
    $ts = "[$(Get-Date -Format s)] $m"
    Write-Host $ts
    $ts | Out-File -FilePath $logFile -Append
}

Log "Disabling Windows Update services and settings..."

try {
    # Stop Windows Update service
    Log "Stopping Windows Update service (wuauserv)..."
    Stop-Service -Name wuauserv -Force -ErrorAction SilentlyContinue
    
    # Disable Windows Update service
    Log "Disabling Windows Update service (wuauserv)..."
    Set-Service -Name wuauserv -StartupType Disabled -ErrorAction Stop
    
    # Disable Windows Update Medic Service (if exists - Windows 10/11)
    Log "Disabling Windows Update Medic service (WaaSMedicSvc)..."
    Stop-Service -Name WaaSMedicSvc -Force -ErrorAction SilentlyContinue
    Set-Service -Name WaaSMedicSvc -StartupType Disabled -ErrorAction SilentlyContinue
    
    # Disable Update Orchestrator Service
    Log "Disabling Update Orchestrator service (UsoSvc)..."
    Stop-Service -Name UsoSvc -Force -ErrorAction SilentlyContinue
    Set-Service -Name UsoSvc -StartupType Disabled -ErrorAction SilentlyContinue
    
    # Configure Windows Update via Registry
    Log "Configuring Windows Update registry settings..."
    
    # Set Group Policy to disable automatic updates
    $auKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
    if (-not (Test-Path $auKey)) {
        New-Item -Path $auKey -Force | Out-Null
    }
    
    # NoAutoUpdate = 1 (Disable automatic updates)
    New-ItemProperty -Path $auKey -Name "NoAutoUpdate" -Value 1 -PropertyType DWord -Force | Out-Null
    
    # AUOptions = 1 (Notify before download)
    New-ItemProperty -Path $auKey -Name "AUOptions" -Value 1 -PropertyType DWord -Force | Out-Null
    
    # Disable Driver updates via Windows Update
    $driverKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
    if (-not (Test-Path $driverKey)) {
        New-Item -Path $driverKey -Force | Out-Null
    }
    New-ItemProperty -Path $driverKey -Name "ExcludeWUDriversInQualityUpdate" -Value 1 -PropertyType DWord -Force | Out-Null
    
    # Disable automatic restart after updates
    New-ItemProperty -Path $auKey -Name "NoAutoRebootWithLoggedOnUsers" -Value 1 -PropertyType DWord -Force | Out-Null
    
    Log "Windows Update has been disabled successfully."
    
    # Verify service status
    $wuService = Get-Service -Name wuauserv
    Log "Windows Update service status: $($wuService.Status), Startup Type: $($wuService.StartType)"
    
    Write-Host "Windows Update disabled successfully!" -ForegroundColor Green
    exit 0
}
catch {
    Log "ERROR: Failed to disable Windows Update - $($_.Exception.Message)"
    Write-Host "ERROR: Failed to disable Windows Update - $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
