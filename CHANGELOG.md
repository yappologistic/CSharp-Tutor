# Changelog

All notable changes to C# Tutor are documented here.

This project uses semantic versioning while it remains pre-1.0:

- `PATCH`: typo fixes, wording tweaks, docs link updates, and non-behavioral maintenance.
- `MINOR`: new references, new scripts, new command modes, new skills, and backward-compatible behavior improvements.
- `MAJOR`: renamed or removed skills, incompatible install layout changes, or intentionally breaking command/behavior changes.

## Unreleased

### Added

- Golden prompt/rubric output quality validation in `tests/golden-qa.json` with `scripts/test-output-quality.ps1`.
- Richer core tutor references with concrete C# examples, triage heuristics, practice exercises, before/after patterns, and good/bad answer comparisons.
- Intent-based skill router reference for mapping natural user prompts, keywords, and pasted diagnostics to the right focused C# skill.
- Modern .NET guidance covering C# 12/13 feature choices, `System.Threading.Channels`, `Microsoft.Extensions.*`, configuration/options, and `HttpClientFactory` patterns.
- Standalone guidance blocks for focused C# skills with a core rule, an anti-pattern, and a minimal example.
- Bash `scripts/install-latest.sh` installer for Linux/macOS with dry-run, backup, validation, list, uninstall, ref, and repository options.
- Cross-platform CI matrix for Windows, Ubuntu, and macOS health checks.
- `csharp-maui` skill and shared MAUI/XAML guidance.
- `csharp-grpc` skill and shared .NET gRPC guidance.
- Cross-skill composition guidance for mixed requests spanning multiple focused skills.

### Changed

- Consolidated wrapper-only `csharp-review`, `csharp-docs`, and `csharp-style` skills into `csharp-tutor` command modes.
- Installer updates now remove manifest-listed retired skill folders so consolidated wrappers do not remain after update.
- Catalog drift checks now normalize line endings so `SKILLS.md` validates consistently on Windows, Linux, and macOS.
- Thickened `csharp-help` and `csharp-json` with skill-specific decision rules and response guidance.
- PowerShell maintenance scripts now resolve `pwsh` on non-Windows systems and use `$HOME` as a default skills root when `$USERPROFILE` is unavailable.

## 0.6.0 - 2026-06-06

### Added

- `csharp-migration` skill and shared migration guidance for .NET Framework, .NET Core, and modern .NET upgrade plans.
- `csharp-blazor` skill and shared Blazor guidance for components, lifecycle, state, rendering, forms, auth, interop, and performance.
- `csharp-signalr` skill and shared SignalR guidance for hubs, clients, groups, reconnects, auth, streaming, scale-out, and diagnostics.
- `csharp-containers` skill and shared container guidance for Dockerfiles, multi-stage builds, image size, non-root execution, health checks, compose, and Kubernetes patterns.
- `csharp-regex` skill and shared Regex guidance for C# patterns, escaping, captures, replacements, timeouts, source-generated regex, and backtracking risks.
- `csharp-sourcegen` skill and shared source generator guidance for Roslyn incremental generators, diagnostics, generated code, testing, build performance, and AOT-friendly generation.
- GitHub Actions CI for PowerShell syntax checks, repository health checks, and whitespace validation.
- Generated `SKILLS.md` catalog sourced from the manifest and skill frontmatter.
- Catalog generator script with drift-check mode for local validation and CI.
- Contributor guide covering skill quality, local checks, catalog generation, and release flow.
- Representative example prompts for every skill.
- Topic coverage map for choosing the right focused skill.
- Known limitations document clarifying runtime, docs, security, review, and installer boundaries.
- Maintenance dashboard script for summarizing package health and required maintenance artifacts.
- Quality rubric for maintaining consistent skill behavior.
- `csharp-nullability` skill and shared nullable reference type guidance.
- Short descriptions for all existing skills that were missing catalog metadata.
- `csharp-build` skill and shared build guidance for SDK, restore, MSBuild, project-file, and CI failures.
- `csharp-logging` skill and shared logging guidance for `ILogger`, structured logging, scopes, Serilog, and safe logs.
- Release helper `-UseCurrentVersion` option for tagging the currently checked-in version after health checks.
- MIT license, GitHub issue and PR templates, GitHub Release publishing support, self-update guidance, and `csharp-quickfix` skill.
- `csharp-nuget` skill and shared NuGet guidance for package metadata, packing, versioning, local testing, Source Link, and publishing safety.
- `csharp-aot` skill and shared AOT/trimming guidance for NativeAOT, linker warnings, reflection risks, serialization compatibility, and publish constraints.
- `csharp-analyzers` skill and shared analyzer guidance for Roslyn analyzers, `.editorconfig`, warning policy, `dotnet format`, and CI quality gates.
- Main `csharp-tutor` orchestrator routing decision tree with focused-skill handoff recommendations.

## 0.5.0 - 2026-06-05

### Added

- Repository health check script for validating skills, manifest consistency, README drift, markdown links, reference targets, version metadata, and installer dry runs.
- Release helper script for updating version metadata, preparing changelog entries, running health checks, and optionally creating/pushing release tags.
- Install troubleshooting guide for execution policy, network, Python, validator, backup, and Codex refresh issues.
- Installer `-ListInstalled` mode for support and diagnostics.
- Installer `-Uninstall` mode with optional backup.
- Backup restore script for restoring previously backed up `csharp-*` skill folders.
- Comment-based PowerShell help for install, bootstrap, health, release, and restore scripts.

### Changed

- Installers now print clearer install/uninstall/list summaries.
- Version metadata now tracks helper script paths in the package manifest.

## 0.4.0 - 2026-06-05

### Added

- One-command GitHub installer for installing and updating skills directly from the remote repository.
- Local install/update helper with dry-run, backup, validation, and custom destination support.
- Official docs map for common C#/.NET, ASP.NET Core, EF Core, DI, testing, tooling, security, and modernization topics.
- Compiler and runtime error library for debugging compiler diagnostics, exceptions, stack traces, and failing behavior.
- Expanded code smell catalog with beginner-safe fixes, production-grade options, "do not fix when" guidance, and test-protection notes.

### Changed

- Wired official docs map into docs-grounded skill behavior.
- Wired compiler/runtime error guidance into debug, errors, and debug-lab flows.
- Updated installation docs around one-command remote install and local install helpers.
- Expanded shared refactor guidance used by review, refactor, OOP, DI, architecture, and design-pattern flows.
