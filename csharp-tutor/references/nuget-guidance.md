# NuGet Guidance

Use this reference for NuGet package creation, metadata, packing, local testing, versioning, symbols, source link, and publishing safety.

## First Checks

- Identify whether the project is an app, library, analyzer, tool, or package-only project.
- Inspect package metadata in `.csproj`, `Directory.Build.props`, and `Directory.Packages.props`.
- Check target frameworks, package references, nullable settings, XML docs, repository metadata, license, readme, icon, and package tags.
- Confirm whether the user wants local testing, CI packing, public publishing, or private feed publishing.

## Common Commands

```powershell
dotnet restore
dotnet build -c Release
dotnet test -c Release --no-build
dotnet pack -c Release --no-build
dotnet nuget push path\to\package.nupkg --source <source>
```

For local package testing:

```powershell
dotnet nuget add source "D:\LocalPackages" --name LocalPackages
dotnet add package PackageId --version 0.1.0-local
```

## Package Metadata Checklist

- `PackageId`
- `Version`
- `Authors`
- `Description`
- `PackageTags`
- `RepositoryUrl`
- `PackageLicenseExpression` or `PackageLicenseFile`
- `PackageReadmeFile` when useful
- `PackageIcon` when useful
- `GenerateDocumentationFile` for public APIs
- `PublishRepositoryUrl`, `EmbedUntrackedSources`, and Source Link when source stepping matters

## Versioning And Compatibility

- Use semantic versioning for public packages.
- Treat public API removals, signature changes, stricter nullability contracts, and target framework drops as compatibility-sensitive.
- Prefer prerelease suffixes for preview packages, such as `1.2.0-beta.1`.
- Avoid publishing throwaway versions to public feeds; package versions are effectively permanent.

## Publishing Safety

- Never include secrets, local paths, test assets, private symbols, or unpublished proprietary files in packages.
- Inspect package contents before publishing when package layout changed.
- Prefer API review and release notes before public package pushes.
- Use private feeds or local folders for validation before public NuGet.org publishing.
