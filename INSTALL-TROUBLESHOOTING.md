# Install Troubleshooting

Use this guide when the one-command installer or local install helper does not behave as expected.

## Recommended Install

```powershell
irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1 | iex
```

Linux/macOS:

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash
```

Preview without copying:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -DryRun
```

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash -s -- --dry-run
```

## PowerShell Blocks Script Execution

If PowerShell blocks script execution, use the remote command above or run the local script with:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\install-csharp-tutor.ps1 -Validate -Backup
```

For a two-step review before executing:

```powershell
irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1 -OutFile install-latest.ps1
Get-Content .\install-latest.ps1
.\install-latest.ps1
```

## GitHub or Internet Access Fails

The one-command installer downloads from GitHub. If GitHub is blocked or offline:

1. Download or clone the repository manually.
2. Open PowerShell in the repository root.
3. Run:

```powershell
.\scripts\install-csharp-tutor.ps1 -Validate -Backup
```

## Python Is Missing

Python is only required for validation and the C# project inspection helper. Install can still work without Python if you skip validation:

```powershell
.\scripts\install-csharp-tutor.ps1 -Backup
```

For the remote installer:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -NoValidate
```

## Skill Validator Is Missing

The remote installer skips validation if Codex's `quick_validate.py` is not found. The local installer fails when `-Validate` is explicitly requested and the validator is missing.

Use:

```powershell
.\scripts\install-csharp-tutor.ps1 -Backup
```

On Linux/macOS, the Bash installer skips validation when the Codex validator is not present unless validation is explicitly available.

## Skills Do Not Appear In Codex

After install:

1. Restart Codex, or open a new thread.
2. Check the destination:

```powershell
.\scripts\install-csharp-tutor.ps1 -ListInstalled
```

3. Confirm folders are under:

```text
%USERPROFILE%\.codex\skills
```

On Linux/macOS, the default is:

```text
~/.codex/skills
```

## Custom Skills Directory

Use `-DestinationRoot`:

```powershell
.\scripts\install-csharp-tutor.ps1 -DestinationRoot "D:\CodexSkills" -Backup
```

## Restore From Backup

Backups are stored under:

```text
%USERPROFILE%\.codex\skills\.backup\csharp-tutor-YYYYMMDD-HHMMSS
```

Restore:

```powershell
.\scripts\restore-backup.ps1 -BackupPath "$env:USERPROFILE\.codex\skills\.backup\csharp-tutor-YYYYMMDD-HHMMSS"
```

Preview restore:

```powershell
.\scripts\restore-backup.ps1 -BackupPath "$env:USERPROFILE\.codex\skills\.backup\csharp-tutor-YYYYMMDD-HHMMSS" -DryRun
```

## Uninstall

Preview:

```powershell
.\scripts\install-csharp-tutor.ps1 -Uninstall -Backup -DryRun
```

Uninstall with backup:

```powershell
.\scripts\install-csharp-tutor.ps1 -Uninstall -Backup
```

## Release And Health Checks

Run repository checks:

```powershell
.\scripts\test-csharp-tutor.ps1
```

Prepare release metadata:

```powershell
.\scripts\release.ps1 -Version 0.6.1
```
