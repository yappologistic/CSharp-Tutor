<#
.SYNOPSIS
Runs repository health checks for the C# Tutor skill pack.

.DESCRIPTION
Validates skill structure, package version metadata, manifest consistency, README skill list drift, markdown links, reference targets, optional Codex skill validation, and optional installer dry runs.

.PARAMETER SourceRoot
Repository root. Defaults to the parent folder of this script.

.PARAMETER DestinationRoot
Codex skills directory used for installer dry-run checks. Defaults to %USERPROFILE%\.codex\skills.

.PARAMETER SkipSkillValidation
Skips running Codex quick_validate.py for every skill folder.

.PARAMETER SkipInstallerDryRun
Skips local installer dry-run verification.

.EXAMPLE
.\scripts\test-csharp-tutor.ps1

.EXAMPLE
.\scripts\test-csharp-tutor.ps1 -SkipInstallerDryRun
#>
[CmdletBinding()]
param(
    [string]$SourceRoot,
    [string]$DestinationRoot,
    [switch]$SkipSkillValidation,
    [switch]$SkipInstallerDryRun
)

$ErrorActionPreference = "Stop"
$script:Failures = @()

function Add-Failure {
    param([string]$Message)
    $script:Failures += $Message
    Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Add-Pass {
    param([string]$Message)
    Write-Host "[PASS] $Message" -ForegroundColor Green
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

function Get-MarkdownLinks {
    param([string]$Text)

    $matches = [regex]::Matches($Text, '\[[^\]]+\]\(([^)]+)\)')
    foreach ($match in $matches) {
        $match.Groups[1].Value
    }
}

function Test-RelativeMarkdownLinks {
    param([System.IO.FileInfo[]]$Files)

    foreach ($file in $Files) {
        $text = Get-Content -LiteralPath $file.FullName -Raw
        foreach ($target in Get-MarkdownLinks -Text $text) {
            if ($target -match '^[a-z]+://' -or $target.StartsWith("#")) {
                continue
            }

            $pathPart = ($target -split '#', 2)[0]
            if ([string]::IsNullOrWhiteSpace($pathPart)) {
                continue
            }

            $resolved = Join-Path $file.DirectoryName $pathPart
            if (-not (Test-Path -LiteralPath $resolved)) {
                Add-Failure "Broken markdown link in $($file.FullName): $target"
            }
        }
    }
}

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = Join-Path $PSScriptRoot ".."
}
$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    if (-not [string]::IsNullOrWhiteSpace($env:USERPROFILE)) {
        $DestinationRoot = Join-Path $env:USERPROFILE ".codex\skills"
    }
}

Write-Host "C# Tutor health check"
Write-Host "Source root: $SourceRoot"
if (-not [string]::IsNullOrWhiteSpace($DestinationRoot)) {
    Write-Host "Destination root: $DestinationRoot"
}

$skillFolders = @(Get-ChildItem -LiteralPath $SourceRoot -Directory -Filter "csharp-*" | Sort-Object Name)
if ($skillFolders.Count -eq 0) {
    Add-Failure "No csharp-* skill folders found."
}
else {
    Add-Pass "Found $($skillFolders.Count) csharp-* skill folders."
}

foreach ($skill in $skillFolders) {
    $skillFile = Join-Path $skill.FullName "SKILL.md"
    $agentFile = Join-Path $skill.FullName "agents\openai.yaml"
    if (-not (Test-Path -LiteralPath $skillFile)) {
        Add-Failure "$($skill.Name) is missing SKILL.md"
        continue
    }
    if (-not (Test-Path -LiteralPath $agentFile)) {
        Add-Failure "$($skill.Name) is missing agents/openai.yaml"
    }

    $nameLine = Select-String -LiteralPath $skillFile -Pattern '^name:\s*(.+)$' | Select-Object -First 1
    if ($null -eq $nameLine) {
        Add-Failure "$($skill.Name) SKILL.md is missing frontmatter name"
    }
    elseif ($nameLine.Matches[0].Groups[1].Value.Trim() -ne $skill.Name) {
        Add-Failure "$($skill.Name) frontmatter name does not match folder"
    }
}
if ($script:Failures.Count -eq 0) {
    Add-Pass "Skill folder structure is consistent."
}

$versionFile = Join-Path $SourceRoot "VERSION"
$manifestFile = Join-Path $SourceRoot "csharp-tutor-manifest.json"
$readmeFile = Join-Path $SourceRoot "README.md"
$changelogFile = Join-Path $SourceRoot "CHANGELOG.md"
$catalogFile = Join-Path $SourceRoot "SKILLS.md"
$promptExamplesFile = Join-Path $SourceRoot "EXAMPLE-PROMPTS.md"

if (-not (Test-Path -LiteralPath $versionFile)) {
    Add-Failure "VERSION file is missing."
}
if (-not (Test-Path -LiteralPath $manifestFile)) {
    Add-Failure "csharp-tutor-manifest.json is missing."
}
if (-not (Test-Path -LiteralPath $changelogFile)) {
    Add-Failure "CHANGELOG.md is missing."
}
if (-not (Test-Path -LiteralPath $catalogFile)) {
    Add-Failure "SKILLS.md is missing."
}
if (-not (Test-Path -LiteralPath $promptExamplesFile)) {
    Add-Failure "EXAMPLE-PROMPTS.md is missing."
}

if ((Test-Path -LiteralPath $versionFile) -and (Test-Path -LiteralPath $manifestFile)) {
    $version = (Get-Content -LiteralPath $versionFile -Raw).Trim()
    $manifest = Get-Content -LiteralPath $manifestFile -Raw | ConvertFrom-Json
    if ($manifest.version -ne $version) {
        Add-Failure "Manifest version '$($manifest.version)' does not match VERSION '$version'."
    }
    else {
        Add-Pass "Manifest version matches VERSION ($version)."
    }

    $folderNames = @($skillFolders | ForEach-Object Name | Sort-Object)
    $manifestSkills = @($manifest.skills | Sort-Object)
    $missing = @($folderNames | Where-Object { $_ -notin $manifestSkills })
    $extra = @($manifestSkills | Where-Object { $_ -notin $folderNames })
    if ($missing.Count -or $extra.Count) {
        Add-Failure "Manifest skill list does not match folders. Missing: $($missing -join ', ') Extra: $($extra -join ', ')"
    }
    else {
        Add-Pass "Manifest skill list matches folders."
    }

    if (Test-Path -LiteralPath $readmeFile) {
        $readme = Get-Content -LiteralPath $readmeFile -Raw
        $expectedReadmeVersion = "Current version: ``$version``"
        if ($readme -notmatch [regex]::Escape($expectedReadmeVersion)) {
            Add-Failure "README current version does not match VERSION."
        }
        else {
            Add-Pass "README current version matches VERSION."
        }

        foreach ($skillName in $folderNames) {
            $expectedSkill = "``$skillName``"
            if ($readme -notmatch [regex]::Escape($expectedSkill)) {
                Add-Failure "README skill list appears to be missing $skillName."
            }
        }
    }

    if (Test-Path -LiteralPath $changelogFile) {
        $changelog = Get-Content -LiteralPath $changelogFile -Raw
        if ($changelog -notmatch "##\s+$([regex]::Escape($version))\b") {
            Add-Failure "CHANGELOG.md is missing a section for $version."
        }
        else {
            Add-Pass "CHANGELOG.md contains a section for $version."
        }
    }

    $catalogGenerator = Join-Path $SourceRoot "scripts\generate-skills-catalog.ps1"
    if (-not (Test-Path -LiteralPath $catalogGenerator)) {
        Add-Failure "Skill catalog generator is missing."
    }
    elseif (Test-Path -LiteralPath $catalogFile) {
        & powershell -NoProfile -ExecutionPolicy Bypass -File $catalogGenerator -SourceRoot $SourceRoot -Check | Out-Host
        if ($LASTEXITCODE -ne 0) {
            Add-Failure "SKILLS.md is stale."
        }
        else {
            Add-Pass "SKILLS.md matches manifest and skill frontmatter."
        }
    }

    if (Test-Path -LiteralPath $promptExamplesFile) {
        $promptExamples = Get-Content -LiteralPath $promptExamplesFile -Raw
        foreach ($skillName in $folderNames) {
            $expectedSkill = "``$skillName``"
            if ($promptExamples -notmatch [regex]::Escape($expectedSkill)) {
                Add-Failure "EXAMPLE-PROMPTS.md is missing $skillName."
            }
        }
        if ($script:Failures.Count -eq 0) {
            Add-Pass "EXAMPLE-PROMPTS.md covers every skill."
        }
    }
}

$markdownFiles = @(
    Get-ChildItem -LiteralPath $SourceRoot -File -Filter "*.md"
    Get-ChildItem -LiteralPath (Join-Path $SourceRoot "csharp-tutor\references") -File -Filter "*.md"
    Get-ChildItem -LiteralPath $SourceRoot -Directory -Filter "csharp-*" | ForEach-Object {
        Get-ChildItem -LiteralPath $_.FullName -File -Filter "SKILL.md"
    }
)
Test-RelativeMarkdownLinks -Files $markdownFiles
if ($script:Failures.Count -eq 0) {
    Add-Pass "Relative markdown links resolve."
}

$referenceRoot = Join-Path $SourceRoot "csharp-tutor\references"
$referencePattern = 'references/([A-Za-z0-9._-]+\.md)'
foreach ($file in @(Get-ChildItem -LiteralPath $SourceRoot -Directory -Filter "csharp-*" | ForEach-Object { Get-ChildItem -LiteralPath $_.FullName -File -Filter "SKILL.md" })) {
    $text = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($match in [regex]::Matches($text, $referencePattern)) {
        $referenceFile = Join-Path $referenceRoot $match.Groups[1].Value
        if (-not (Test-Path -LiteralPath $referenceFile)) {
            Add-Failure "Missing referenced file from $($file.FullName): $($match.Groups[0].Value)"
        }
    }
}

if (-not $SkipSkillValidation) {
    $validator = Get-QuickValidatorPath -SkillsRoot $DestinationRoot
    if ($null -eq $validator) {
        Add-Failure "quick_validate.py was not found; rerun with -SkipSkillValidation to skip this check."
    }
    else {
        foreach ($skill in $skillFolders) {
            & python $validator $skill.FullName | Out-Host
            if ($LASTEXITCODE -ne 0) {
                Add-Failure "Skill validation failed: $($skill.Name)"
            }
        }
        Add-Pass "Skill validation completed."
    }
}

if (-not $SkipInstallerDryRun) {
    $installer = Join-Path $SourceRoot "scripts\install-csharp-tutor.ps1"
    if (-not (Test-Path -LiteralPath $installer)) {
        Add-Failure "Local installer script is missing."
    }
    else {
        & powershell -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $DestinationRoot -DryRun | Out-Host
        if ($LASTEXITCODE -ne 0) {
            Add-Failure "Installer dry run failed."
        }
        else {
            Add-Pass "Installer dry run completed."
        }
    }
}

if ($script:Failures.Count -gt 0) {
    Write-Host ""
    Write-Host "Health check failed with $($script:Failures.Count) issue(s)." -ForegroundColor Red
    foreach ($failure in $script:Failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host ""
Write-Host "Health check passed." -ForegroundColor Green
