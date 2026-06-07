<#
.SYNOPSIS
Prints a maintenance dashboard for the C# Tutor skill pack.

.DESCRIPTION
Summarizes package metadata, skill coverage, documentation artifacts, validation helpers, and common maintenance gaps.
Use -Check to fail when required maintenance artifacts are missing or generated files are stale.

.PARAMETER SourceRoot
Repository root. Defaults to the parent folder of this script.

.PARAMETER Check
Exits with a non-zero code if required maintenance artifacts are missing or stale.

.EXAMPLE
.\scripts\get-maintenance-dashboard.ps1

.EXAMPLE
.\scripts\get-maintenance-dashboard.ps1 -Check
#>
[CmdletBinding()]
param(
    [string]$SourceRoot,
    [switch]$Check
)

$ErrorActionPreference = "Stop"
$failures = @()

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = Join-Path $PSScriptRoot ".."
}
$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path

function Add-CheckFailure {
    param([string]$Message)
    $script:failures += $Message
}

function Test-File {
    param([string]$RelativePath)

    return Test-Path -LiteralPath (Join-Path $SourceRoot $RelativePath)
}

function Get-FrontmatterValue {
    param(
        [string]$Text,
        [string]$Key
    )

    $match = [regex]::Match($Text, "(?m)^$([regex]::Escape($Key)):\s*(.+)$")
    if ($match.Success) {
        return $match.Groups[1].Value.Trim()
    }

    return ""
}

$versionFile = Join-Path $SourceRoot "VERSION"
$manifestFile = Join-Path $SourceRoot "csharp-tutor-manifest.json"
$referenceRoot = Join-Path $SourceRoot "csharp-tutor\references"

if (-not (Test-Path -LiteralPath $versionFile)) {
    Add-CheckFailure "VERSION is missing."
}
if (-not (Test-Path -LiteralPath $manifestFile)) {
    Add-CheckFailure "csharp-tutor-manifest.json is missing."
}

$version = if (Test-Path -LiteralPath $versionFile) { (Get-Content -LiteralPath $versionFile -Raw).Trim() } else { "unknown" }
$manifest = if (Test-Path -LiteralPath $manifestFile) { Get-Content -LiteralPath $manifestFile -Raw | ConvertFrom-Json } else { $null }
$skillFolders = @(Get-ChildItem -LiteralPath $SourceRoot -Directory -Filter "csharp-*" | Sort-Object Name)
$referenceFiles = if (Test-Path -LiteralPath $referenceRoot) { @(Get-ChildItem -LiteralPath $referenceRoot -File -Filter "*.md") } else { @() }

$missingShortDescription = @()
foreach ($skill in $skillFolders) {
    $skillFile = Join-Path $skill.FullName "SKILL.md"
    if (-not (Test-Path -LiteralPath $skillFile)) {
        continue
    }

    $text = Get-Content -LiteralPath $skillFile -Raw
    $shortDescription = Get-FrontmatterValue -Text $text -Key "  short-description"
    if ([string]::IsNullOrWhiteSpace($shortDescription)) {
        $missingShortDescription += $skill.Name
    }
}

$requiredArtifacts = @(
    "README.md",
    "CHANGELOG.md",
    "CONTRIBUTING.md",
    "LICENSE",
    "RELEASE.md",
    "QUALITY-RUBRIC.md",
    "SKILLS.md",
    "TOPICS.md",
    "EXAMPLE-PROMPTS.md",
    "KNOWN-LIMITATIONS.md",
    ".github\ISSUE_TEMPLATE\bug_report.md",
    ".github\ISSUE_TEMPLATE\feature_request.md",
    ".github\pull_request_template.md",
    ".github\workflows\ci.yml",
    "scripts\generate-skills-catalog.ps1",
    "scripts\test-csharp-tutor.ps1"
)

foreach ($artifact in $requiredArtifacts) {
    if (-not (Test-File -RelativePath $artifact)) {
        Add-CheckFailure "Missing maintenance artifact: $artifact"
    }
}

$changelogHasUnreleased = $false
if (Test-File -RelativePath "CHANGELOG.md") {
    $changelogHasUnreleased = (Get-Content -LiteralPath (Join-Path $SourceRoot "CHANGELOG.md") -Raw) -match '(?m)^##\s+Unreleased\b'
    if (-not $changelogHasUnreleased) {
        Add-CheckFailure "CHANGELOG.md is missing an Unreleased section."
    }
}

$catalogCurrent = $false
$catalogGenerator = Join-Path $SourceRoot "scripts\generate-skills-catalog.ps1"
if (Test-Path -LiteralPath $catalogGenerator) {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $catalogGenerator -SourceRoot $SourceRoot -Check *> $null
    $catalogCurrent = ($LASTEXITCODE -eq 0)
    if (-not $catalogCurrent) {
        Add-CheckFailure "SKILLS.md is stale."
    }
}

$manifestSkillCount = if ($null -ne $manifest) { @($manifest.skills).Count } else { 0 }
$folderSkillCount = $skillFolders.Count
$skillCountMatchesManifest = ($manifestSkillCount -eq $folderSkillCount)
if (-not $skillCountMatchesManifest) {
    Add-CheckFailure "Manifest skill count ($manifestSkillCount) does not match folder count ($folderSkillCount)."
}

Write-Host "C# Tutor maintenance dashboard"
Write-Host "Source root: $SourceRoot"
Write-Host ""
Write-Host "Version: $version"
Write-Host "Skills: $folderSkillCount folder(s), $manifestSkillCount manifest entrie(s)"
Write-Host "References: $($referenceFiles.Count)"
Write-Host "Skills missing short-description: $($missingShortDescription.Count)"
if ($missingShortDescription.Count -gt 0) {
    Write-Host "  $($missingShortDescription -join ', ')"
}
Write-Host ""
Write-Host "Artifacts:"
foreach ($artifact in $requiredArtifacts) {
    $state = if (Test-File -RelativePath $artifact) { "present" } else { "missing" }
    Write-Host "  $artifact`: $state"
}
Write-Host ""
Write-Host "Checks:"
Write-Host "  Catalog current: $catalogCurrent"
Write-Host "  Changelog Unreleased section: $changelogHasUnreleased"
Write-Host "  Manifest skill count matches folders: $skillCountMatchesManifest"

if ($Check -and $failures.Count -gt 0) {
    Write-Host ""
    Write-Host "Maintenance dashboard check failed:" -ForegroundColor Red
    foreach ($failure in $failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

if ($Check) {
    Write-Host ""
    Write-Host "Maintenance dashboard check passed." -ForegroundColor Green
}
