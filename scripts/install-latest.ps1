[CmdletBinding()]
param(
    [string]$Branch = "master",
    [string]$Repository = "yappologistic/CSharp-Tutor",
    [string]$DestinationRoot,
    [switch]$DryRun,
    [switch]$NoBackup,
    [switch]$NoValidate,
    [switch]$KeepDownload
)

$ErrorActionPreference = "Stop"

function Get-QuickValidatorPath {
    param([string]$SkillsRoot)

    $candidates = @()
    if (-not [string]::IsNullOrWhiteSpace($SkillsRoot)) {
        $candidates += (Join-Path $SkillsRoot ".system\skill-creator\scripts\quick_validate.py")
    }
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        $candidates += (Join-Path $env:USERPROFILE ".codex\skills\.system\skill-creator\scripts\quick_validate.py")
    }

    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }

    return $null
}

function New-TempInstallRoot {
    $base = Join-Path ([System.IO.Path]::GetTempPath()) "csharp-tutor-install"
    $name = "{0:yyyyMMdd-HHmmss}-{1}" -f (Get-Date), ([System.Guid]::NewGuid().ToString("N").Substring(0, 8))
    $path = Join-Path $base $name
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    return $path
}

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    if ([string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        throw "USERPROFILE is not set. Pass -DestinationRoot explicitly."
    }
    $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
}

$archiveUrl = "https://github.com/$Repository/archive/refs/heads/$Branch.zip"
$tempRoot = New-TempInstallRoot
$zipPath = Join-Path $tempRoot "source.zip"
$extractRoot = Join-Path $tempRoot "source"

try {
    Write-Host "Downloading C# Tutor skills from $archiveUrl"
    Invoke-WebRequest -Uri $archiveUrl -OutFile $zipPath -UseBasicParsing

    Write-Host "Extracting package"
    Expand-Archive -LiteralPath $zipPath -DestinationPath $extractRoot -Force

    $repoRoot = Get-ChildItem -LiteralPath $extractRoot -Directory | Select-Object -First 1
    if ($null -eq $repoRoot) {
        throw "Downloaded archive did not contain a repository folder."
    }

    $installer = Join-Path $repoRoot.FullName "scripts\install-csharp-tutor.ps1"
    if (-not (Test-Path -LiteralPath $installer)) {
        throw "Installer script was not found in downloaded package: $installer"
    }

    $installerArgs = @(
        "-SourceRoot", $repoRoot.FullName,
        "-DestinationRoot", $DestinationRoot
    )

    if ($DryRun) {
        $installerArgs += "-DryRun"
    }

    if (-not $NoBackup) {
        $installerArgs += "-Backup"
    }

    if (-not $NoValidate) {
        $validator = Get-QuickValidatorPath -SkillsRoot $DestinationRoot
        if ($null -ne $validator) {
            $installerArgs += "-Validate"
        }
        else {
            Write-Warning "quick_validate.py was not found. Skipping validation. Install Codex's skill validator or rerun from an environment where it is available to validate before copying."
        }
    }

    Write-Host "Running installer from downloaded package"
    & powershell -NoProfile -ExecutionPolicy Bypass -File $installer @installerArgs
    if ($LASTEXITCODE -ne 0) {
        throw "Installer failed with exit code $LASTEXITCODE."
    }
}
finally {
    if ($KeepDownload) {
        Write-Host "Kept downloaded files at $tempRoot"
    }
    elseif (Test-Path -LiteralPath $tempRoot) {
        Remove-Item -LiteralPath $tempRoot -Recurse -Force
    }
}
