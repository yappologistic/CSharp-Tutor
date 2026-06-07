# Release Process

Use this process to publish a stable C# Tutor release after changes have been reviewed and committed.

## Checks

Run the full health check first:

```powershell
.\scripts\test-csharp-tutor.ps1
```

Confirm the working tree is clean:

```powershell
git status --short
```

## Tag Current Version

To tag the current `VERSION`, push the tag, and create a draft GitHub Release using the matching `CHANGELOG.md` section:

```powershell
.\scripts\release.ps1 -UseCurrentVersion -CreateTag -PushTag -CreateGitHubRelease -Draft
```

Remove `-Draft` only when the release notes and tag are ready to publish immediately.

## New Version

To prepare a new version, update metadata, run health checks, push the tag, and create a draft GitHub Release:

```powershell
.\scripts\release.ps1 -Version 0.6.1 -CreateTag -PushTag -CreateGitHubRelease -Draft
```

## Requirements

- GitHub CLI installed as `gh`.
- Authenticated GitHub CLI session:

```powershell
gh auth login
```

- A `CHANGELOG.md` section matching the release version.

## Notes

- GitHub Releases change remote state. Create them only after review and after the release commit has been pushed.
- Use draft releases when you want to review release notes before publishing.
