<#
.SYNOPSIS
Installs, updates, lists, or uninstalls the C# Tutor Codex skills from a local repository checkout.

.DESCRIPTION
Copies all csharp-* skill folders from a source repository into a Codex skills directory.
The script can validate source skills before copying, back up existing installed skills, list installed skills, or uninstall installed C# Tutor skills.

.PARAMETER SourceRoot
Repository root containing csharp-* skill folders. Defaults to the parent folder of this script.

.PARAMETER DestinationRoot
Codex skills directory. Defaults to %USERPROFILE%\.codex\skills.

.PARAMETER SourceRef
Human-readable source label printed in summaries, such as local or owner/repo@v0.5.0.

.PARAMETER DryRun
Shows actions without copying or deleting files.

.PARAMETER Backup
Backs up existing installed csharp-* folders before install or uninstall.

.PARAMETER Validate
Runs Codex skill validation on source skill folders before install.

.PARAMETER ListInstalled
Lists installed csharp-* folders in the destination and exits.

.PARAMETER Uninstall
Removes installed csharp-* folders from the destination. Use with -Backup to preserve a restorable copy.

.PARAMETER Force
Allows install, update, or uninstall against a destination that does not look like a Codex skills directory.

.EXAMPLE
.\scripts\install-csharp-tutor.ps1 -Validate -Backup

.EXAMPLE
.\scripts\install-csharp-tutor.ps1 -ListInstalled

.EXAMPLE
.\scripts\install-csharp-tutor.ps1 -Uninstall -Backup -DryRun
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourceRoot,
    [string]$DestinationRoot,
    [string]$SourceRef = "local",
    [switch]$DryRun,
    [switch]$Backup,
    [switch]$Validate,
    [switch]$ListInstalled,
    [switch]$Uninstall,
    [switch]$Force
)

$ErrorActionPreference = "Stop"

function Resolve-RootPath {
    param(
        [string]$Path,
        [string]$Fallback,
        [switch]$MustExist
    )

    if ([string]::IsNullOrWhiteSpace($Path)) {
        $Path = $Fallback
    }

    if ($MustExist -and -not (Test-Path -LiteralPath $Path)) {
        throw "Path does not exist: $Path"
    }

    if (Test-Path -LiteralPath $Path) {
        return (Resolve-Path -LiteralPath $Path).Path
    }

    return $Path
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
    if (-not [string]::IsNullOrWhiteSpace($env:HOME)) {
        $candidates += (Join-Path $env:HOME ".codex/skills/.system/skill-creator/scripts/quick_validate.py")
    }

    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate) {
            return $candidate
        }
    }

    return $null
}

function Get-DefaultSkillsRoot {
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        return Join-Path $env:USERPROFILE ".codex\skills"
    }
    if (-not [string]::IsNullOrWhiteSpace($env:HOME)) {
        return Join-Path $env:HOME ".codex/skills"
    }

    throw "Neither USERPROFILE nor HOME is set. Pass -DestinationRoot explicitly."
}

function Test-IsCodexSkillsRoot {
    param([string]$Path)

    if ([string]::IsNullOrWhiteSpace($Path)) {
        return $false
    }

    $normalized = $Path.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    $leaf = Split-Path -Leaf $normalized
    $parent = Split-Path -Parent $normalized
    if ($leaf -ne "skills" -or [string]::IsNullOrWhiteSpace($parent)) {
        return $false
    }

    $parentLeaf = Split-Path -Leaf $parent.TrimEnd([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)
    return $parentLeaf -eq ".codex"
}

function Assert-SafeDestinationRoot {
    param(
        [string]$Path,
        [switch]$Force
    )

    if ($Force) {
        return
    }

    if (-not (Test-IsCodexSkillsRoot -Path $Path)) {
        throw "DestinationRoot must look like a Codex skills directory ending in '.codex\skills'. Pass -Force to use this destination intentionally: $Path"
    }
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

function Get-InstalledSkillFolders {
    param([string]$SkillsRoot)

    if (-not (Test-Path -LiteralPath $SkillsRoot)) {
        return @()
    }

    return @(Get-ChildItem -LiteralPath $SkillsRoot -Directory -Filter "csharp-*" | Sort-Object Name)
}

function New-BackupRoot {
    param([string]$SkillsRoot)

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    return Join-Path $SkillsRoot ".backup\csharp-tutor-$timestamp"
}

function Backup-SkillFolder {
    param(
        [System.IO.DirectoryInfo]$Skill,
        [string]$BackupRoot,
        [switch]$DryRun
    )

    $backupTarget = Join-Path $BackupRoot $Skill.Name
    if ($DryRun) {
        Write-Host "Would back up existing $($Skill.FullName) to $backupTarget"
        return
    }

    New-Item -ItemType Directory -Path $BackupRoot -Force | Out-Null
    Copy-Item -LiteralPath $Skill.FullName -Destination $backupTarget -Recurse -Force
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

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    $DestinationRoot = Get-DefaultSkillsRoot
}
$DestinationRoot = Resolve-RootPath -Path $DestinationRoot -Fallback $DestinationRoot
Assert-SafeDestinationRoot -Path $DestinationRoot -Force:$Force

if ($ListInstalled) {
    Write-Host "Destination root: $DestinationRoot"
    $installed = Get-InstalledSkillFolders -SkillsRoot $DestinationRoot
    if ($installed.Count -eq 0) {
        Write-Host "No installed csharp-* skill folders found."
        exit 0
    }

    $installed | Select-Object Name, FullName, LastWriteTime | Format-Table -AutoSize
    Write-Host "Installed C# Tutor skill folders: $($installed.Count)"
    exit 0
}

$repoRoot = Resolve-RootPath -Path $SourceRoot -Fallback (Join-Path $PSScriptRoot "..") -MustExist
$packageVersion = Get-PackageVersion -Root $repoRoot
$sourceSkillFolders = @(Get-ChildItem -LiteralPath $repoRoot -Directory -Filter "csharp-*" | Sort-Object Name)

if ($sourceSkillFolders.Count -eq 0) {
    throw "No csharp-* skill folders found under $repoRoot"
}

Write-Host "Source root: $repoRoot"
Write-Host "Source ref: $SourceRef"
Write-Host "C# Tutor version: $packageVersion"
Write-Host "Destination root: $DestinationRoot"
Write-Host "Skill folders: $($sourceSkillFolders.Count)"

if ($Validate -and -not $Uninstall) {
    $validator = Get-QuickValidatorPath -SkillsRoot $DestinationRoot
    Invoke-SkillValidation -SkillFolders $sourceSkillFolders -ValidatorPath $validator
}

if ($Uninstall) {
    $installed = Get-InstalledSkillFolders -SkillsRoot $DestinationRoot
    if ($installed.Count -eq 0) {
        Write-Host "No installed csharp-* skill folders found."
        exit 0
    }

    $backupRoot = if ($Backup) { New-BackupRoot -SkillsRoot $DestinationRoot } else { $null }
    foreach ($skill in $installed) {
        if ($Backup) {
            Backup-SkillFolder -Skill $skill -BackupRoot $backupRoot -DryRun:$DryRun
        }

        if ($DryRun) {
            Write-Host "Would remove $($skill.FullName)"
        }
        elseif ($PSCmdlet.ShouldProcess($skill.FullName, "Remove installed C# Tutor skill")) {
            Remove-Item -LiteralPath $skill.FullName -Recurse -Force
        }
    }

    Write-Host "Uninstalled C# Tutor skill folders: $($installed.Count)"
    if ($Backup) {
        Write-Host "Backup location: $backupRoot"
    }
    exit 0
}

if ($DryRun) {
    Write-Host "Dry run only. No files will be copied."
    foreach ($skill in $sourceSkillFolders) {
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

$backupRoot = if ($Backup) { New-BackupRoot -SkillsRoot $DestinationRoot } else { $null }

foreach ($skill in $sourceSkillFolders) {
    $target = Join-Path $DestinationRoot $skill.Name

    if ($Backup -and (Test-Path -LiteralPath $target)) {
        $existing = Get-Item -LiteralPath $target
        Backup-SkillFolder -Skill $existing -BackupRoot $backupRoot
    }

    if ($PSCmdlet.ShouldProcess($target, "Install or update from $($skill.FullName)")) {
        if (Test-Path -LiteralPath $target) {
            Remove-Item -LiteralPath $target -Recurse -Force
        }
        Copy-Item -LiteralPath $skill.FullName -Destination $DestinationRoot -Recurse -Force
    }
}

Write-Host "Installed or updated $($sourceSkillFolders.Count) C# Tutor skill folders."
Write-Host "C# Tutor version: $packageVersion"
if ($Backup) {
    Write-Host "Backup location: $backupRoot"
}
Write-Host "Restart Codex or open a new thread if the skill picker does not refresh immediately."
