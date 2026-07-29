param(
    [ValidateSet("global", "local")]
    [string]$Scope = "global",
    [string]$AgentName = "teacher-api",
    [switch]$SetDefault
)

$ErrorActionPreference = "Stop"
$RepoRoot = $PSScriptRoot
$AgentFile = Join-Path $RepoRoot ".opencode" "agents" "${AgentName}.md"

if (-not (Test-Path $AgentFile)) {
    # try agents/ folder as fallback
    $AgentFile = Join-Path $RepoRoot "agents" "${AgentName}.md"
}

if (-not (Test-Path $AgentFile)) {
    Write-Error "Agent file not found: ${AgentName}.md"
    exit 1
}

if ($Scope -eq "global") {
    $AgentDir = Join-Path $env:USERPROFILE ".config" "opencode" "agents"
} else {
    $AgentDir = Join-Path (Get-Location) ".opencode" "agents"
}

New-Item -ItemType Directory -Path $AgentDir -Force | Out-Null
Copy-Item -Path $AgentFile -Destination (Join-Path $AgentDir "${AgentName}.md") -Force

Write-Host "[OK] Agent installed to: $AgentDir" -ForegroundColor Green

if ($SetDefault -and $Scope -eq "global") {
    $ConfigFile = Join-Path $env:USERPROFILE ".config" "opencode" "opencode.json"

    if (Test-Path $ConfigFile) {
        $Config = Get-Content $ConfigFile -Raw | ConvertFrom-Json
        $Config.default_agent = $AgentName
        $Config | ConvertTo-Json -Depth 32 | Set-Content $ConfigFile -NoNewline
        Write-Host "[OK] Default agent set to '$AgentName' in global config" -ForegroundColor Green
    } else {
        $Config = @{
            '$schema' = "https://opencode.ai/config.json"
            default_agent = $AgentName
        }
        New-Item -ItemType File -Path $ConfigFile -Force | Out-Null
        $Config | ConvertTo-Json -Depth 32 | Set-Content $ConfigFile -NoNewline
        Write-Host "[OK] Global config created with default agent '$AgentName'" -ForegroundColor Green
    }
}

Write-Host "`nInstallation complete. Restart opencode to use the agent." -ForegroundColor Cyan
Write-Host "Usage: @${AgentName} Quero aprender a construir uma API" -ForegroundColor Cyan
