# Known Limitations

C# Tutor is a Codex skill pack, not a compiler, analyzer, debugger, or replacement for official migration testing. These limits are intentional so the project stays clear about what it can and cannot safely promise.

## Runtime And Build Limits

- The skills do not execute arbitrary C# code by themselves.
- The project inspection helper reads project metadata, but it does not perform full semantic analysis of C# source code.
- Build, test, format, package, and analyzer commands still need to be run in the user's actual project when correctness matters.
- Suggestions about performance should be treated as hypotheses until measured with profiling or benchmarks.

## Documentation And Version Limits

- C# and .NET behavior can be version-sensitive. Skills should prefer official Microsoft documentation for language rules, API behavior, framework guidance, security, compatibility, and performance-sensitive claims.
- The repository does not vendor Microsoft documentation.
- Guidance that depends on current framework behavior may need browsing or source verification at answer time.
- Version upgrade advice does not replace testing the target project against the intended SDK, target framework, packages, analyzers, and deployment environment.

## Security Limits

- Security review skills can identify common risks, but they are not a substitute for threat modeling, dependency scanning, penetration testing, or organization-specific security review.
- Secrets, private tokens, production credentials, and private customer data should not be pasted into prompts or committed to this repository.
- Vulnerability guidance can become stale and should be verified against current advisories and official security documentation.

## Learning And Review Limits

- The tutor aims to teach and explain tradeoffs, but it may need more project context before giving final architecture or design recommendations.
- Code review skills should separate required fixes from optional improvements, but users still need to decide based on their product constraints.
- Beginner-friendly defaults may simplify details unless the user asks for deeper internals or production constraints.

## Installer Limits

- The installer copies skill folders into a local Codex skills directory; users may need to restart Codex or start a new thread before new skills appear.
- Network installs depend on GitHub availability, PowerShell execution policy, archive download support, and local filesystem permissions.
- Backups protect overwritten skill folders, but they are not a full repository history or system backup.
