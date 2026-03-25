$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location (Join-Path $ScriptDir "..")

# Load .env if it exists
$envFile = Join-Path "src" ".env"
if (Test-Path $envFile) {
    Get-Content $envFile | ForEach-Object {
        if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
            [System.Environment]::SetEnvironmentVariable($Matches[1].Trim(), $Matches[2].Trim(), "Process")
        }
    }
}

$env:PYTHONPATH = Join-Path (Get-Location) "src"

$Timeout = 30
$SalesProcess = $null
$InventoryProcess = $null

function Wait-ForHealth {
    param([int]$Port, [string]$Name)

    for ($i = 0; $i -lt $Timeout; $i++) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:${Port}/health" -UseBasicParsing -TimeoutSec 2 -ErrorAction SilentlyContinue
            if ($response.StatusCode -eq 200) {
                Write-Host "  $Name is ready on port $Port" -ForegroundColor Green
                return
            }
        } catch {}
        Start-Sleep -Seconds 1
    }

    Write-Host "  $Name failed to start within ${Timeout}s" -ForegroundColor Red
    Stop-AllServers
    exit 1
}

function Stop-AllServers {
    Write-Host ""
    Write-Host "Shutting down MCP servers..." -ForegroundColor Yellow
    foreach ($proc in @($SalesProcess, $InventoryProcess)) {
        if ($proc -and -not $proc.HasExited) {
            Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
        }
    }
    Write-Host "Done."
}

try {
    # Start Sales Analysis first
    Write-Host "Starting Sales Analysis MCP Server (port 8004)..." -ForegroundColor Cyan
    $env:PORT = "8004"
    $SalesProcess = Start-Process python -ArgumentList "-m", "mcp_servers.sales_analysis" -PassThru -NoNewWindow

    Wait-ForHealth -Port 8004 -Name "Sales Analysis"

    # Start Inventory after Sales Analysis is healthy
    Write-Host "Starting Inventory MCP Server (port 8005)..." -ForegroundColor Cyan
    $env:PORT = "8005"
    $InventoryProcess = Start-Process python -ArgumentList "-m", "mcp_servers.inventory_server" -PassThru -NoNewWindow

    Wait-ForHealth -Port 8005 -Name "Inventory"

    Write-Host ""
    Write-Host "All MCP servers are running" -ForegroundColor Green
    Write-Host "   Sales Analysis: http://localhost:8004/mcp"
    Write-Host "   Inventory:      http://localhost:8005/mcp"
    Write-Host ""
    Write-Host "Press Ctrl+C to stop all servers."

    # Wait until either process exits
    while (-not $SalesProcess.HasExited -and -not $InventoryProcess.HasExited) {
        Start-Sleep -Seconds 1
    }
} finally {
    Stop-AllServers
}
