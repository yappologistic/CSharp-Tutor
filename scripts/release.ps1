<#
.SYNOPSIS
Prepares C# Tutor version metadata and optionally creates a git release tag.

.DESCRIPTION
Updates VERSION, csharp-tutor-manifest.json, README current version, and CHANGELOG.md for a new semantic version.
By default it runs the repository health check after updates. Tag creation is opt-in through -CreateTag.

.PARAMETER Version
New semantic version, such as 0.5.1.

.PARAMETER UseCurrentVersion
Uses the existing VERSION file value instead of requiring -Version. This is useful for tagging the currently checked-in release after validation.

.PARAMETER SourceRoot
Repository root. Defaults to the parent folder of this script.

.PARAMETER CreateTag
Creates git tag v<Version> after metadata is updated and health checks pass.

.PARAMETER PushTag
Pushes the created tag to origin. Requires -CreateTag.

.PARAMETER CreateGitHubRelease
Creates a GitHub Release for v<Version> using the matching CHANGELOG.md section as release notes. Requires GitHub CLI authentication.

.PARAMETER Draft
Creates the GitHub Release as a draft. Only applies with -CreateGitHubRelease.

.PARAMETER Prerelease
Marks the GitHub Release as a prerelease. Only applies with -CreateGitHubRelease.

.PARAMETER SkipHealthCheck
Skips running scripts/test-csharp-tutor.ps1 after metadata updates.

.EXAMPLE
.\scripts\release.ps1 -Version 0.5.1

.EXAMPLE
.\scripts\release.ps1 -Version 0.5.1 -CreateTag -PushTag

.EXAMPLE
.\scripts\release.ps1 -UseCurrentVersion -CreateTag -PushTag

.EXAMPLE
.\scripts\release.ps1 -UseCurrentVersion -CreateTag -PushTag -CreateGitHubRelease -Draft
#>
[CmdletBinding()]
param(
    [string]$Version,
    [string]$SourceRoot,
    [switch]$UseCurrentVersion,
    [switch]$CreateTag,
    [switch]$PushTag,
    [switch]$CreateGitHubRelease,
    [switch]$Draft,
    [switch]$Prerelease,
    [switch]$SkipHealthCheck
)

$ErrorActionPreference = "Stop"

if ($PushTag -and -not $CreateTag) {
    throw "-PushTag requires -CreateTag."
}

if (($Draft -or $Prerelease) -and -not $CreateGitHubRelease) {
    throw "-Draft and -Prerelease require -CreateGitHubRelease."
}

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = Join-Path $PSScriptRoot ".."
}
$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path

$versionFile = Join-Path $SourceRoot "VERSION"
$manifestFile = Join-Path $SourceRoot "csharp-tutor-manifest.json"
$readmeFile = Join-Path $SourceRoot "README.md"
$changelogFile = Join-Path $SourceRoot "CHANGELOG.md"
$updateMetadata = -not $UseCurrentVersion

if ($UseCurrentVersion) {
    if (-not [string]::IsNullOrWhiteSpace($Version)) {
        throw "Use either -Version or -UseCurrentVersion, not both."
    }
    $Version = (Get-Content -LiteralPath $versionFile -Raw).Trim()
}

if ([string]::IsNullOrWhiteSpace($Version)) {
    throw "Version is required unless -UseCurrentVersion is provided."
}

if ($Version -notmatch '^\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?$') {
    throw "Version must be semantic version format, such as 0.5.1 or 1.0.0-beta.1."
}

function Get-ChangelogReleaseNotes {
    param(
        [string]$Path,
        [string]$ReleaseVersion
    )

    $text = Get-Content -LiteralPath $Path -Raw
    $escapedVersion = [regex]::Escape($ReleaseVersion)
    $match = [regex]::Match($text, "(?ms)^##\s+$escapedVersion(?:\s+-[^\r\n]*)?\s*\r?\n(?<body>.*?)(?=^##\s+|\z)")
    if (-not $match.Success) {
        throw "CHANGELOG.md does not contain a section for $ReleaseVersion."
    }

    $body = $match.Groups["body"].Value.Trim()
    if ([string]::IsNullOrWhiteSpace($body)) {
        throw "CHANGELOG.md section for $ReleaseVersion is empty."
    }

    return $body
}

if ($updateMetadata) {
    Set-Content -LiteralPath $versionFile -Value $Version -Encoding utf8

    $manifest = Get-Content -LiteralPath $manifestFile -Raw | ConvertFrom-Json
    $manifest.version = $Version
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestFile -Encoding utf8

    $readme = Get-Content -LiteralPath $readmeFile -Raw
    $readme = [regex]::Replace($readme, 'Current version: `[^`]+`', ('Current version: `' + $Version + '`'))
    $readme = [regex]::Replace($readme, 'git tag v\d+\.\d+\.\d+([-.0-9A-Za-z]+)?', ('git tag v' + $Version))
    $readme = [regex]::Replace($readme, 'git push origin v\d+\.\d+\.\d+([-.0-9A-Za-z]+)?', ('git push origin v' + $Version))
    $readme = [regex]::Replace($readme, '-Ref v\d+\.\d+\.\d+([-.0-9A-Za-z]+)?', ('-Ref v' + $Version))
    Set-Content -LiteralPath $readmeFile -Value $readme -Encoding utf8

    $changelog = Get-Content -LiteralPath $changelogFile -Raw
    if ($changelog -notmatch "##\s+$([regex]::Escape($Version))\b") {
        $date = Get-Date -Format "yyyy-MM-dd"
        $section = @(
            "## $Version - $date",
            "",
            "### Added",
            "",
            "- TODO: Summarize added features.",
            "",
            "### Changed",
            "",
            "- TODO: Summarize changed behavior or documentation.",
            ""
        ) -join "`r`n"
        $changelog = $changelog -replace '(?m)^##\s+', "$section`r`n## "
        Set-Content -LiteralPath $changelogFile -Value $changelog -Encoding utf8
    }
}

$tagName = "v$Version"

if (-not $SkipHealthCheck) {
    $health = Join-Path $SourceRoot "scripts\test-csharp-tutor.ps1"
    & powershell -NoProfile -ExecutionPolicy Bypass -File $health -SourceRoot $SourceRoot
    if ($LASTEXITCODE -ne 0) {
        throw "Health check failed. Release metadata was updated, but tag creation was stopped."
    }
}

if ($CreateTag) {
    git -C $SourceRoot rev-parse -q --verify "refs/tags/$tagName" *> $null
    if ($LASTEXITCODE -eq 0) {
        throw "Git tag $tagName already exists."
    }

    git -C $SourceRoot tag $tagName
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create git tag $tagName."
    }

    if ($PushTag) {
        git -C $SourceRoot push origin $tagName
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to push git tag $tagName."
        }
    }
}

if ($CreateGitHubRelease) {
    $gh = Get-Command gh -ErrorAction SilentlyContinue
    if ($null -eq $gh) {
        throw "GitHub CLI 'gh' was not found. Install it and authenticate with 'gh auth login' before creating a GitHub Release."
    }

    $notes = Get-ChangelogReleaseNotes -Path $changelogFile -ReleaseVersion $Version
    $notesFile = New-TemporaryFile
    try {
        Set-Content -LiteralPath $notesFile.FullName -Value $notes -Encoding utf8
        $releaseArgs = @("release", "create", $tagName, "--title", $tagName, "--notes-file", $notesFile.FullName)
        if ($Draft) {
            $releaseArgs += "--draft"
        }
        if ($Prerelease) {
            $releaseArgs += "--prerelease"
        }

        & gh @releaseArgs
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to create GitHub Release $tagName."
        }
    }
    finally {
        Remove-Item -LiteralPath $notesFile.FullName -Force -ErrorAction SilentlyContinue
    }
}

if ($UseCurrentVersion) {
    Write-Host "Prepared C# Tutor release tag flow for current version $Version."
}
else {
    Write-Host "Prepared C# Tutor release metadata for $Version."
}
