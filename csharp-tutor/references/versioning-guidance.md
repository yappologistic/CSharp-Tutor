# Versioning Guidance

Use this reference for C# language versions, .NET target frameworks, SDK defaults, project configuration, feature availability, modernization readiness, trimming, AOT, and compatibility.

## First Checks

- Inspect `global.json`, `.csproj`, `Directory.Build.props`, `Directory.Packages.props`, and `.editorconfig` when available.
- Identify target framework, SDK pinning, `LangVersion`, nullable setting, implicit usings, package versions, analyzers, trimming, AOT, and platform-specific targets.
- If no `LangVersion` is set, explain that language version usually follows SDK and target framework defaults, then verify with official docs before making a precise claim.

## Review Priorities

1. Whether the syntax is available in the project's C# language version.
2. Whether the API is available in the target framework or package version.
3. Whether nullable, trimming, AOT, analyzers, or source generators affect the recommendation.
4. Whether the change is source-compatible, binary-compatible, or behavior-preserving.
5. Whether modernization improves clarity, safety, performance, or maintainability enough to justify compatibility cost.

## Common Feedback

- Do not recommend new syntax before checking `LangVersion` or project defaults when code is project-specific.
- Do not assume a newer .NET runtime just because the local machine has it installed.
- Separate language features from BCL/framework APIs; they have different compatibility checks.
- Suggest small compatibility-safe modernizations first.
- For libraries, consider consumers, public API compatibility, trimming, AOT, and package target frameworks.

## Source Standard

Use official Microsoft docs for language-version defaults, target framework support, API availability, compatibility notes, and "What's new" guidance. Include concise citations or source names when the answer depends on those facts.
