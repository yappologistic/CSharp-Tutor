[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourceRoot,
    [string]$DestinationRoot,
    [string]$SourceRef = "local",
    [switch]$DryRun,
    [switch]$Backup,
    [switch]$Validate
)

$ErrorActionPreference = "Stop"

function Resolve-RootPath {
    param(
        [string]$Path,
        [string]$Fallback
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        $Path = $Fallback
    }

    if (-not (Test-Path -LiteralPath $Path)) {
        throw "Path does not exist: $Path"
    }

    return (Resolve-Path -LiteralPath $Path).Path
}

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

function Get-PackageVersion {
    param([string]$Root)

    $versionFile = Join-Path $Root "VERSION"
    if (Test-Path -LiteralPath $versionFile) {
        $version = (Get-Content -LiteralPath $versionFile -Raw).Trim()
        if (-not [string]::IsNullOrWhiteSpace($version)) {
            return $version
        }
    }

    $manifestFile = Join-Path $Root "csharp-tutor-manifest.json"
    if (Test-Path -LiteralPath $manifestFile) {
        try {
            $manifest = Get-Content -LiteralPath $manifestFile -Raw | ConvertFrom-Json
            if (-not [string]::IsNullOrWhiteSpace($manifest.version)) {
                return $manifest.version
            }
        }
        catch {
            Write-Warning "Could not read version from manifest: $manifestFile"
        }
    }

    return "unknown"
}

function Invoke-SkillValidation {
    param(
        [System.IO.DirectoryInfo[]]$SkillFolders,
        [string]$ValidatorPath
    )

    if ([string]::IsNullOrWhiteSpace($ValidatorPath)) {
        throw "Cannot validate because quick_validate.py was not found under the destination skills root or the default Codex skills root."
    }

    foreach ($skill in $SkillFolders) {
        Write-Host "Validating $($skill.Name)"
        & python $ValidatorPath $skill.FullName
        if ($LASTEXITCODE -ne 0) {
            throw "Validation failed for $($skill.FullName)"
        }
    }
}

$repoRoot = Resolve-RootPath -Path $SourceRoot -Fallback (Join-Path $PSScriptRoot "..")
$packageVersion = Get-PackageVersion -Root $repoRoot

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    if ([string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        throw "USERPROFILE is not set. Pass -DestinationRoot explicitly."
    }
    $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
}

$skillFolders = @(Get-ChildItem -LiteralPath $repoRoot -Directory -Filter "csharp-*" | Sort-Object Name)

if ($skillFolders.Count -eq 0) {
    throw "No csharp-* skill folders found under $repoRoot"
}

Write-Host "Source root: $repoRoot"
Write-Host "Source ref: $SourceRef"
Write-Host "C# Tutor version: $packageVersion"
Write-Host "Destination root: $DestinationRoot"
Write-Host "Skill folders: $($skillFolders.Count)"

if ($Validate) {
    $validator = Get-QuickValidatorPath -SkillsRoot $DestinationRoot
    Invoke-SkillValidation -SkillFolders $skillFolders -ValidatorPath $validator
}

if ($DryRun) {
    Write-Host "Dry run only. No files will be copied."
    foreach ($skill in $skillFolders) {
        $target = Join-Path $DestinationRoot $skill.Name
        if (Test-Path -LiteralPath $target) {
            if ($Backup) {
                Write-Host "Would back up existing $target"
            }
            Write-Host "Would update $target from $($skill.FullName)"
        }
        else {
            Write-Host "Would install $target from $($skill.FullName)"
        }
    }
    exit 0
}

if (-not (Test-Path -LiteralPath $DestinationRoot)) {
    if ($PSCmdlet.ShouldProcess($DestinationRoot, "Create destination skills directory")) {
        New-Item -ItemType Directory -Path $DestinationRoot -Force | Out-Null
    }
}

$backupRoot = $null
if ($Backup) {
    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $backupRoot = Join-Path $DestinationRoot ".backup\csharp-tutor-$timestamp"
    if ($PSCmdlet.ShouldProcess($backupRoot, "Create backup directory")) {
        New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
    }
}

foreach ($skill in $skillFolders) {
    $target = Join-Path $DestinationRoot $skill.Name

    if ($Backup -and (Test-Path -LiteralPath $target)) {
        $backupTarget = Join-Path $backupRoot $skill.Name
        if ($PSCmdlet.ShouldProcess($backupTarget, "Back up existing $target")) {
            Copy-Item -LiteralPath $target -Destination $backupTarget -Recurse -Force
        }
    }

    if ($PSCmdlet.ShouldProcess($target, "Install or update from $($skill.FullName)")) {
        Copy-Item -LiteralPath $skill.FullName -Destination $DestinationRoot -Recurse -Force
    }
}

Write-Host "Installed or updated $($skillFolders.Count) C# Tutor skill folders."
Write-Host "C# Tutor version: $packageVersion"
if ($Backup) {
    Write-Host "Backup location: $backupRoot"
}
Write-Host "Restart Codex or open a new thread if the skill picker does not refresh immediately."
