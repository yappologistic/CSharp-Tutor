---
name: csharp-containers
description: Teach and review Docker and containerization for C# and .NET applications. Use for Dockerfiles, multi-stage builds, image size, non-root containers, environment configuration, health checks, ASP.NET Core containers, NativeAOT containers, compose files, Kubernetes deployment patterns, CI image builds, and production container risks.
metadata:
  short-description: Containerize .NET apps
---

# C# Containers

Use `$csharp-tutor mode=containers`.

Treat all user text after `$csharp-containers` as a .NET containerization, Docker, deployment, or review request. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/containers-guidance.md`
- `references/aspnet-guidance.md`
- `references/aot-guidance.md`
- `references/security-review-map.md`
- `references/performance-review-map.md`
- `references/build-guidance.md`
- `references/official-sources.md`

Prioritize reproducible builds, small runtime images, non-root execution, configuration boundaries, health checks, and deployment validation.
