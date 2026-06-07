<#
.SYNOPSIS
Restores C# Tutor skill folders from a backup created by the installer.

.DESCRIPTION
Copies csharp-* folders from a backup directory back into a Codex skills directory. Existing destination folders are overwritten.

.PARAMETER BackupPath
Path to a backup folder such as %USERPROFILE%\.codex\skills\.backup\csharp-tutor-YYYYMMDD-HHMMSS.

.PARAMETER DestinationRoot
Codex skills directory. Defaults to %USERPROFILE%\.codex\skills.

.PARAMETER DryRun
Shows restore actions without copying files.

.EXAMPLE
.\scripts\restore-backup.ps1 -BackupPath "$env:USERPROFILE\.codex\skills\.backup\csharp-tutor-20260605-120000"

.EXAMPLE
.\scripts\restore-backup.ps1 -BackupPath .\backup -DryRun
#>
[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$BackupPath,
    [string]$DestinationRoot,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $BackupPath)) {
    throw "Backup path does not exist: $BackupPath"
}
$BackupPath = (Resolve-Path -LiteralPath $BackupPath).Path

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
    }
    elseif (-not [string]::IsNullOrWhiteSpace($env:HOME)) {
        $DestinationRoot = Join-Path $env:HOME ".codex/skills"
    }
    else {
        throw "Neither USERPROFILE nor HOME is set. Pass -DestinationRoot explicitly."
    }
}

$skills = @(Get-ChildItem -LiteralPath $BackupPath -Directory -Filter "csharp-*" | Sort-Object Name)
if ($skills.Count -eq 0) {
    throw "No csharp-* folders found under backup path: $BackupPath"
}

Write-Host "Backup path: $BackupPath"
Write-Host "Destination root: $DestinationRoot"
Write-Host "Skill folders to restore: $($skills.Count)"

if ($DryRun) {
    foreach ($skill in $skills) {
        Write-Host "Would restore $($skill.Name) to $DestinationRoot"
    }
    exit 0
}

if (-not (Test-Path -LiteralPath $DestinationRoot)) {
    New-Item -ItemType Directory -Path $DestinationRoot -Force | Out-Null
}

foreach ($skill in $skills) {
    $target = Join-Path $DestinationRoot $skill.Name
    if ($PSCmdlet.ShouldProcess($target, "Restore from $($skill.FullName)")) {
        Copy-Item -LiteralPath $skill.FullName -Destination $DestinationRoot -Recurse -Force
    }
}

Write-Host "Restored $($skills.Count) C# Tutor skill folders."
