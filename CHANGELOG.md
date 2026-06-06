# Changelog

All notable changes to C# Tutor are documented here.

This project uses semantic versioning while it remains pre-1.0:

- `PATCH`: typo fixes, wording tweaks, docs link updates, and non-behavioral maintenance.
- `MINOR`: new references, new scripts, new command modes, new skills, and backward-compatible behavior improvements.
- `MAJOR`: renamed or removed skills, incompatible install layout changes, or intentionally breaking command/behavior changes.

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
