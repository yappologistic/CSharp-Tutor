<#
.SYNOPSIS
Validates C# Tutor golden prompt quality tests and optionally scores captured answers.

.DESCRIPTION
Checks tests/golden-qa.json for duplicate ids, required fields, expected key points,
and forbidden phrase lists. When answer files exist in tests/answers/<id>.md, scores
each answer by checking whether each expected key point has at least one matching
signal and whether forbidden phrases appear.

.PARAMETER SourceRoot
Repository root. Defaults to the parent folder of this script.

.PARAMETER AnswersRoot
Folder containing captured answer markdown files named <case-id>.md.

.EXAMPLE
.\scripts\test-output-quality.ps1

.EXAMPLE
.\scripts\test-output-quality.ps1 -AnswersRoot .\tests\answers
#>
[CmdletBinding()]
param(
    [string]$SourceRoot,
    [string]$AnswersRoot
)

$ErrorActionPreference = "Stop"
$failures = @()

function Add-Failure {
    param([string]$Message)
    $script:failures += $Message
    Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Add-Pass {
    param([string]$Message)
    Write-Host "[PASS] $Message" -ForegroundColor Green
}

function Test-TextContainsAny {
    param(
        [string]$Text,
        [object[]]$Needles
    )

    foreach ($needle in $Needles) {
        if ([string]::IsNullOrWhiteSpace([string]$needle)) {
            continue
        }

        if ($Text.IndexOf([string]$needle, [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
            return $true
        }
    }

    return $false
}

if ([string]::IsNullOrWhiteSpace($SourceRoot)) {
    $SourceRoot = Join-Path $PSScriptRoot ".."
}
$SourceRoot = (Resolve-Path -LiteralPath $SourceRoot).Path

if ([string]::IsNullOrWhiteSpace($AnswersRoot)) {
    $AnswersRoot = Join-Path $SourceRoot "tests\answers"
}
elseif (-not [System.IO.Path]::IsPathRooted($AnswersRoot)) {
    $AnswersRoot = Join-Path $SourceRoot $AnswersRoot
}

$goldenFile = Join-Path $SourceRoot "tests\golden-qa.json"
if (-not (Test-Path -LiteralPath $goldenFile)) {
    Add-Failure "Missing tests/golden-qa.json."
}
else {
    $golden = Get-Content -LiteralPath $goldenFile -Raw | ConvertFrom-Json
    if ($golden.schemaVersion -ne 1) {
        Add-Failure "Unsupported golden QA schemaVersion '$($golden.schemaVersion)'."
    }

    $cases = @($golden.cases)
    if ($cases.Count -eq 0) {
        Add-Failure "tests/golden-qa.json contains no cases."
    }

    $ids = @{}
    foreach ($case in $cases) {
        if ([string]::IsNullOrWhiteSpace($case.id)) {
            Add-Failure "A golden QA case is missing id."
            continue
        }
        if ($ids.ContainsKey($case.id)) {
            Add-Failure "Duplicate golden QA case id '$($case.id)'."
        }
        $ids[$case.id] = $true

        if ($case.id -notmatch '^[a-z0-9][a-z0-9-]*$') {
            Add-Failure "Golden QA case '$($case.id)' id must be lowercase kebab-case."
        }
        if ([string]::IsNullOrWhiteSpace($case.prompt)) {
            Add-Failure "Golden QA case '$($case.id)' is missing prompt."
        }
        if ([string]::IsNullOrWhiteSpace($case.mode)) {
            Add-Failure "Golden QA case '$($case.id)' is missing mode."
        }

        $keyPoints = @($case.expectedKeyPoints)
        if ($keyPoints.Count -lt 3) {
            Add-Failure "Golden QA case '$($case.id)' needs at least three expected key points."
        }
        foreach ($point in $keyPoints) {
            if ([string]::IsNullOrWhiteSpace($point.label)) {
                Add-Failure "Golden QA case '$($case.id)' has a key point without label."
            }
            if (@($point.mustIncludeAny).Count -eq 0) {
                Add-Failure "Golden QA case '$($case.id)' key point '$($point.label)' has no mustIncludeAny signals."
            }
        }

        if ($null -eq $case.minScore -or [int]$case.minScore -lt 1 -or [int]$case.minScore -gt $keyPoints.Count) {
            Add-Failure "Golden QA case '$($case.id)' has invalid minScore."
        }
        if (@($case.rubric).Count -eq 0) {
            Add-Failure "Golden QA case '$($case.id)' needs human-review rubric entries."
        }

        $answerFile = Join-Path $AnswersRoot "$($case.id).md"
        if (Test-Path -LiteralPath $answerFile) {
            $answer = Get-Content -LiteralPath $answerFile -Raw
            $score = 0
            foreach ($point in $keyPoints) {
                if (Test-TextContainsAny -Text $answer -Needles @($point.mustIncludeAny)) {
                    $score++
                }
                else {
                    Add-Failure "Answer '$answerFile' missed key point: $($point.label)"
                }
            }

            foreach ($forbidden in @($case.mustAvoidAny)) {
                if (-not [string]::IsNullOrWhiteSpace([string]$forbidden) -and
                    $answer.IndexOf([string]$forbidden, [System.StringComparison]::OrdinalIgnoreCase) -ge 0) {
                    Add-Failure "Answer '$answerFile' contains forbidden phrase: $forbidden"
                }
            }

            if ($score -lt [int]$case.minScore) {
                Add-Failure "Answer '$answerFile' scored $score/$($keyPoints.Count), below minScore $($case.minScore)."
            }
            else {
                Add-Pass "Answer '$($case.id)' scored $score/$($keyPoints.Count)."
            }
        }
    }

    if ($script:failures.Count -eq 0) {
        Add-Pass "Golden QA definitions are valid ($($cases.Count) case(s))."
    }
}

if ($script:failures.Count -gt 0) {
    Write-Host ""
    Write-Host "Output quality check failed with $($script:failures.Count) issue(s)." -ForegroundColor Red
    foreach ($failure in $script:failures) {
        Write-Host "- $failure" -ForegroundColor Red
    }
    exit 1
}

Write-Host ""
Write-Host "Output quality check passed." -ForegroundColor Green
