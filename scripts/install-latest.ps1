<#
.SYNOPSIS
Downloads the latest C# Tutor repository archive and runs the local install/update helper.

.DESCRIPTION
Fetches a branch, tag, or commit archive from GitHub, extracts it to a temporary folder, then runs scripts/install-csharp-tutor.ps1 from the downloaded package.
By default it backs up existing installed csharp-* skills and validates source skills when Codex's validator is available.

.PARAMETER Ref
Branch, tag, or commit archive reference to install. Defaults to the value of -Branch.

.PARAMETER Branch
Backward-compatible branch parameter. Defaults to master.

.PARAMETER Repository
GitHub repository in owner/name form. Defaults to yappologistic/CSharp-Tutor.

.PARAMETER DestinationRoot
Codex skills directory. Defaults to %USERPROFILE%\.codex\skills.

.PARAMETER DryRun
Shows install, update, backup, or uninstall actions without copying or deleting files.

.PARAMETER NoBackup
Skips the default backup behavior.

.PARAMETER NoValidate
Skips validation even when Codex's validator is available.

.PARAMETER ListInstalled
Lists installed csharp-* folders and exits after downloading the installer package.

.PARAMETER Uninstall
Uninstalls installed csharp-* folders. Existing folders are backed up unless -NoBackup is provided.

.PARAMETER KeepDownload
Keeps the downloaded temporary package for troubleshooting.

.EXAMPLE
irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1 | iex

.EXAMPLE
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -DryRun

.EXAMPLE
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -Ref v0.6.0
#>
[CmdletBinding()]
param(
    [string]$Ref,
    [string]$Branch = "master",
    [string]$Repository = "yappologistic/CSharp-Tutor",
    [string]$DestinationRoot,
    [switch]$DryRun,
    [switch]$NoBackup,
    [switch]$NoValidate,
    [switch]$ListInstalled,
    [switch]$Uninstall,
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

function Get-ArchiveUrl {
    param(
        [string]$Repository,
        [string]$Ref
    )

    return "https://github.com/$Repository/archive/$Ref.zip"
}

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    if ([string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        throw "USERPROFILE is not set. Pass -DestinationRoot explicitly."
    }
    $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
}

if ([string]::IsNullOrWhiteSpace($Ref)) {
    $Ref = $Branch
}

$archiveUrl = Get-ArchiveUrl -Repository $Repository -Ref $Ref
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

    $versionFile = Join-Path $repoRoot.FullName "VERSION"
    $packageVersion = "unknown"
    if (Test-Path -LiteralPath $versionFile) {
        $packageVersion = (Get-Content -LiteralPath $versionFile -Raw).Trim()
    }

    $installer = Join-Path $repoRoot.FullName "scripts\install-csharp-tutor.ps1"
    if (-not (Test-Path -LiteralPath $installer)) {
        throw "Installer script was not found in downloaded package: $installer"
    }

    $installerArgs = @(
        "-SourceRoot", $repoRoot.FullName,
        "-DestinationRoot", $DestinationRoot
    )

    if (Select-String -LiteralPath $installer -Pattern "SourceRef" -Quiet) {
        $installerArgs += @("-SourceRef", "$Repository@$Ref")
    }

    if ($DryRun) {
        $installerArgs += "-DryRun"
    }

    if (-not $NoBackup) {
        $installerArgs += "-Backup"
    }

    if ($ListInstalled) {
        $installerArgs += "-ListInstalled"
    }

    if ($Uninstall) {
        $installerArgs += "-Uninstall"
    }

    if (-not $NoValidate -and -not $ListInstalled -and -not $Uninstall) {
        $validator = Get-QuickValidatorPath -SkillsRoot $DestinationRoot
        if ($null -ne $validator) {
            $installerArgs += "-Validate"
        }
        else {
            Write-Warning "quick_validate.py was not found. Skipping validation. Install Codex's skill validator or rerun from an environment where it is available to validate before copying."
        }
    }

    Write-Host "Running installer from downloaded package"
    Write-Host "C# Tutor version: $packageVersion"
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
