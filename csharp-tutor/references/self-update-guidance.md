# Self-Update Guidance

Use this reference when the user asks whether C# Tutor is up to date, how to update installed skills, how to reinstall, or how to check what is installed.

## Main Update Command

Recommend rerunning the one-command installer:

```powershell
irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1 | iex
```

On Linux or macOS, recommend the Bash installer:

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash
```

This downloads the latest repository archive, backs up existing installed `csharp-*` skill folders by default, validates when the local Codex validator is available, and copies the skills into the Codex skills directory.

## Safer Checks

Preview without changing files:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -DryRun
```

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash -s -- --dry-run
```

List installed C# Tutor skills:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -ListInstalled
```

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash -s -- --list-installed
```

Install a pinned release:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.ps1))) -Ref v0.6.0
```

```bash
curl -fsSL https://raw.githubusercontent.com/yappologistic/CSharp-Tutor/master/scripts/install-latest.sh | bash -s -- --ref v0.6.0
```

## Response Pattern

When the user asks "am I up to date?":

1. Explain that C# Tutor itself cannot inspect remote GitHub state from inside an installed skill unless the environment lets Codex run commands or browse.
2. Offer `-ListInstalled` to inspect local installed skill folders.
3. Suggest `-DryRun` to preview an update.
4. Suggest rerunning the installer to update.
5. Tell the user to restart Codex or start a new thread if the skill picker does not refresh.

## Safety Notes

- Do not claim the user's installed version is current unless verified from local files and the remote ref.
- Prefer `-DryRun` when the user wants to check first.
- Mention backups when reassuring users about rerunning the installer.
