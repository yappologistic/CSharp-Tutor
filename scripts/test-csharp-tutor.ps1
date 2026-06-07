<#
.SYNOPSIS
Runs repository health checks for the C# Tutor skill pack.

.DESCRIPTION
Validates skill structure, package version metadata, manifest consistency, README skill list drift, markdown links, reference targets, optional Codex skill validation, and installer dry/real runs.

.PARAMETER SourceRoot
Repository root. Defaults to the parent folder of this script.

.PARAMETER DestinationRoot
Codex skills directory used for installer dry-run checks. Defaults to %USERPROFILE%\.codex\skills.

.PARAMETER SkipSkillValidation
Skips running Codex quick_validate.py for every skill folder.

.PARAMETER SkipInstallerDryRun
Skips local installer dry-run verification.

.PARAMETER SkipInstallerRealRun
Skips isolated temp install/uninstall verification.

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
    [switch]$SkipInstallerDryRun,
    [switch]$SkipInstallerRealRun
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

    return ""
}

function Get-PowerShellHost {
    $pwsh = Get-Command pwsh -ErrorAction SilentlyContinue
    if ($null -ne $pwsh) {
        return $pwsh.Source
    }

    $powershell = Get-Command powershell -ErrorAction SilentlyContinue
    if ($null -ne $powershell) {
        return $powershell.Source
    }

    throw "Neither pwsh nor powershell was found."
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

function Get-MatchValue {
    param(
        [string]$Text,
        [string]$Pattern
    )

    $match = [regex]::Match($Text, $Pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)
    if (-not $match.Success) {
        return ""
    }

    return $match.Groups[1].Value.Trim()
}

function Test-SkillFolders {
    param([System.IO.DirectoryInfo[]]$SkillFolders)

    foreach ($skill in $SkillFolders) {
        $skillFile = Join-Path $skill.FullName "SKILL.md"
        $agentFile = Join-Path $skill.FullName "agents\openai.yaml"
        if (-not (Test-Path -LiteralPath $skillFile)) {
            Add-Failure "$($skill.Name) is missing SKILL.md."
            continue
        }

        $skillText = Get-Content -LiteralPath $skillFile -Raw
        $name = Get-MatchValue -Text $skillText -Pattern '^name:\s*(.+)$'
        $description = Get-MatchValue -Text $skillText -Pattern '^description:\s*(.+)$'
        $shortDescription = Get-MatchValue -Text $skillText -Pattern '^\s{2}short-description:\s*(.+)$'

        if ([string]::IsNullOrWhiteSpace($name)) {
            Add-Failure "$($skill.Name) SKILL.md is missing frontmatter name."
        }
        elseif ($name -ne $skill.Name) {
            Add-Failure "$($skill.Name) frontmatter name does not match folder."
        }
        if ([string]::IsNullOrWhiteSpace($description)) {
            Add-Failure "$($skill.Name) SKILL.md is missing frontmatter description."
        }
        if ([string]::IsNullOrWhiteSpace($shortDescription)) {
            Add-Failure "$($skill.Name) SKILL.md is missing metadata.short-description."
        }

        if (-not (Test-Path -LiteralPath $agentFile)) {
            Add-Failure "$($skill.Name) is missing agents/openai.yaml."
            continue
        }

        $agentText = Get-Content -LiteralPath $agentFile -Raw
        $displayName = Get-MatchValue -Text $agentText -Pattern '^\s{2}display_name:\s*(.+)$'
        $agentShortDescription = Get-MatchValue -Text $agentText -Pattern '^\s{2}short_description:\s*(.+)$'
        $defaultPrompt = Get-MatchValue -Text $agentText -Pattern '^\s{2}default_prompt:\s*(.+)$'
        if ([string]::IsNullOrWhiteSpace($displayName)) {
            Add-Failure "$($skill.Name) agents/openai.yaml is missing interface.display_name."
        }
        if ([string]::IsNullOrWhiteSpace($agentShortDescription)) {
            Add-Failure "$($skill.Name) agents/openai.yaml is missing interface.short_description."
        }
        if ([string]::IsNullOrWhiteSpace($defaultPrompt)) {
            Add-Failure "$($skill.Name) agents/openai.yaml is missing interface.default_prompt."
        }
    }
}

function Get-ChangelogSection {
    param(
        [string]$Text,
        [string]$Version
    )

    $escapedVersion = [regex]::Escape($Version)
    $match = [regex]::Match($Text, "(?ms)^##\s+$escapedVersion(?:\s+-[^\r\n]*)?\s*\r?\n(?<body>.*?)(?=^##\s+|\z)")
    if (-not $match.Success) {
        return $null
    }

    return $match.Groups["body"].Value
}

function New-TempDirectory {
    $base = Join-Path ([System.IO.Path]::GetTempPath()) "csharp-tutor-health"
    $name = [System.Guid]::NewGuid().ToString("N")
    $path = Join-Path $base $name
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    return $path
}

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = Join-Path $PSScriptRoot ".."
}
$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path
$powerShellHost = Get-PowerShellHost

if ([string]::IsNullOrWhiteSpace($DestinationRoot)) {
    $DestinationRoot = Get-DefaultSkillsRoot
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

Test-SkillFolders -SkillFolders $skillFolders
if ($script:Failures.Count -eq 0) {
    Add-Pass "Skill folder structure, frontmatter, and agent metadata are complete."
}

$versionFile = Join-Path $SourceRoot "VERSION"
$manifestFile = Join-Path $SourceRoot "csharp-tutor-manifest.json"
$readmeFile = Join-Path $SourceRoot "README.md"
$changelogFile = Join-Path $SourceRoot "CHANGELOG.md"
$catalogFile = Join-Path $SourceRoot "SKILLS.md"
$promptExamplesFile = Join-Path $SourceRoot "EXAMPLE-PROMPTS.md"
$topicsFile = Join-Path $SourceRoot "TOPICS.md"
$limitationsFile = Join-Path $SourceRoot "KNOWN-LIMITATIONS.md"
$qualityTestScript = Join-Path $SourceRoot "scripts\test-output-quality.ps1"

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
if (-not (Test-Path -LiteralPath $topicsFile)) {
    Add-Failure "TOPICS.md is missing."
}
if (-not (Test-Path -LiteralPath $limitationsFile)) {
    Add-Failure "KNOWN-LIMITATIONS.md is missing."
}
if (-not (Test-Path -LiteralPath $qualityTestScript)) {
    Add-Failure "Output quality test script is missing."
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
            $releaseSection = Get-ChangelogSection -Text $changelog -Version $version
            if ($null -ne $releaseSection -and $releaseSection -match '(?im)\bTODO\b') {
                Add-Failure "CHANGELOG.md section for $version still contains TODO placeholder text."
            }
        }
    }

    $catalogGenerator = Join-Path $SourceRoot "scripts\generate-skills-catalog.ps1"
    if (-not (Test-Path -LiteralPath $catalogGenerator)) {
        Add-Failure "Skill catalog generator is missing."
    }
    elseif (Test-Path -LiteralPath $catalogFile) {
        & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $catalogGenerator -SourceRoot $SourceRoot -Check | Out-Host
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

    if (Test-Path -LiteralPath $topicsFile) {
        $topics = Get-Content -LiteralPath $topicsFile -Raw
        foreach ($skillName in $folderNames) {
            $expectedSkill = "``$skillName``"
            if ($topics -notmatch [regex]::Escape($expectedSkill)) {
                Add-Failure "TOPICS.md is missing $skillName."
            }
        }
    }

    $dashboard = Join-Path $SourceRoot "scripts\get-maintenance-dashboard.ps1"
    if (-not (Test-Path -LiteralPath $dashboard)) {
        Add-Failure "Maintenance dashboard script is missing."
    }
    else {
        & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $dashboard -SourceRoot $SourceRoot -Check | Out-Host
        if ($LASTEXITCODE -ne 0) {
            Add-Failure "Maintenance dashboard check failed."
        }
        else {
            Add-Pass "Maintenance dashboard check completed."
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

if (Test-Path -LiteralPath $qualityTestScript) {
    & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $qualityTestScript -SourceRoot $SourceRoot | Out-Host
    if ($LASTEXITCODE -ne 0) {
        Add-Failure "Output quality golden QA check failed."
    }
    else {
        Add-Pass "Output quality golden QA check completed."
    }
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
        & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $DestinationRoot -DryRun | Out-Host
        if ($LASTEXITCODE -ne 0) {
            Add-Failure "Installer dry run failed."
        }
        else {
            Add-Pass "Installer dry run completed."
        }
    }
}

if (-not $SkipInstallerRealRun) {
    $installer = Join-Path $SourceRoot "scripts\install-csharp-tutor.ps1"
    $restore = Join-Path $SourceRoot "scripts\restore-backup.ps1"
    if (-not (Test-Path -LiteralPath $installer)) {
        Add-Failure "Local installer script is missing."
    }
    else {
        $tempDestination = New-TempDirectory
        try {
            $previousErrorActionPreference = $ErrorActionPreference
            $ErrorActionPreference = "Continue"
            & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $tempDestination -DryRun *> $null
            $guardExitCode = $LASTEXITCODE
            $ErrorActionPreference = $previousErrorActionPreference
            if ($guardExitCode -eq 0) {
                Add-Failure "Installer accepted a nonstandard temp destination without -Force."
            }

            & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $tempDestination -Force | Out-Host
            if ($LASTEXITCODE -ne 0) {
                Add-Failure "Installer temp install failed."
            }
            else {
                $installed = @(Get-ChildItem -LiteralPath $tempDestination -Directory -Filter "csharp-*" -ErrorAction SilentlyContinue)
                if ($installed.Count -ne $skillFolders.Count) {
                    Add-Failure "Installer temp install copied $($installed.Count) skill folder(s), expected $($skillFolders.Count)."
                }

                $staleFile = Join-Path $tempDestination "csharp-tutor\stale-file.tmp"
                Set-Content -LiteralPath $staleFile -Value "stale" -Encoding utf8
                $retiredSkillFolder = Join-Path $tempDestination "csharp-review"
                New-Item -ItemType Directory -Path $retiredSkillFolder -Force | Out-Null
                Set-Content -LiteralPath (Join-Path $retiredSkillFolder "stale-retired.tmp") -Value "stale" -Encoding utf8
                & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $tempDestination -Force | Out-Host
                if ($LASTEXITCODE -ne 0) {
                    Add-Failure "Installer temp reinstall failed."
                }
                elseif (Test-Path -LiteralPath $staleFile) {
                    Add-Failure "Installer temp reinstall left a stale file in an existing skill folder."
                }
                elseif (Test-Path -LiteralPath $retiredSkillFolder) {
                    Add-Failure "Installer temp reinstall left retired skill folder: $retiredSkillFolder"
                }

                if (Test-Path -LiteralPath $restore) {
                    $backupRoot = Join-Path $tempDestination ".restore-test"
                    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
                    Copy-Item -LiteralPath (Join-Path $tempDestination "csharp-tutor") -Destination $backupRoot -Recurse -Force
                    $restoreStaleFile = Join-Path $tempDestination "csharp-tutor\restore-stale-file.tmp"
                    Set-Content -LiteralPath $restoreStaleFile -Value "stale" -Encoding utf8
                    $previousErrorActionPreference = $ErrorActionPreference
                    $ErrorActionPreference = "Continue"
                    & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $restore -BackupPath $backupRoot -DestinationRoot $tempDestination *> $null
                    $restoreGuardExitCode = $LASTEXITCODE
                    $ErrorActionPreference = $previousErrorActionPreference
                    if ($restoreGuardExitCode -eq 0) {
                        Add-Failure "Restore accepted a nonstandard temp destination without -Force."
                    }

                    & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $restore -BackupPath $backupRoot -DestinationRoot $tempDestination -Force | Out-Host
                    if ($LASTEXITCODE -ne 0) {
                        Add-Failure "Restore temp run failed."
                    }
                    elseif (Test-Path -LiteralPath $restoreStaleFile) {
                        Add-Failure "Restore temp run left a stale file in an existing skill folder."
                    }
                }
                else {
                    Add-Failure "Backup restore script is missing."
                }
            }

            & $powerShellHost -NoProfile -ExecutionPolicy Bypass -File $installer -SourceRoot $SourceRoot -DestinationRoot $tempDestination -Uninstall -Force | Out-Host
            if ($LASTEXITCODE -ne 0) {
                Add-Failure "Installer temp uninstall failed."
            }
            else {
                $remaining = @(Get-ChildItem -LiteralPath $tempDestination -Directory -Filter "csharp-*" -ErrorAction SilentlyContinue)
                if ($remaining.Count -ne 0) {
                    Add-Failure "Installer temp uninstall left $($remaining.Count) csharp-* folder(s)."
                }
            }

            if ($script:Failures.Count -eq 0) {
                Add-Pass "Installer temp install/uninstall completed."
            }
        }
        finally {
            if (Test-Path -LiteralPath $tempDestination) {
                Remove-Item -LiteralPath $tempDestination -Recurse -Force -ErrorAction SilentlyContinue
            }
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
