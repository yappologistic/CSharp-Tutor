---
name: csharp-grpc
description: Teach and review gRPC services and clients in C# and .NET. Use for proto contracts, service implementation, clients, streaming, deadlines, cancellation, interceptors, metadata, authentication, authorization, error handling, versioning, ASP.NET Core hosting, testing, and production diagnostics.
metadata:
  short-description: gRPC services and clients in .NET
---

# C# gRPC

Use `$csharp-tutor mode=grpc`.

Treat all user text after `$csharp-grpc` as a gRPC service, client, contract, debugging, review, or architecture question. Use the main [csharp-tutor](../csharp-tutor/SKILL.md) skill as the source of truth.

Load these csharp-tutor references when useful:

- `references/grpc-guidance.md`
- `references/aspnet-guidance.md`
- `references/api-design-guidance.md`
- `references/security-review-map.md`
- `references/performance-review-map.md`
- `references/testing-guidance.md`
- `references/official-sources.md`

Prioritize contract compatibility, deadlines, cancellation, streaming behavior, auth, error mapping, and observability before style feedback.

## Standalone Guidance

- Core rule: Keep the answer centered on the concrete grpc decision, failure mode, or contract.
- Avoid: Giving generic C# advice without tying it to the grpc concern.
- Minimal example: `rpc GetOrder (GetOrderRequest) returns (GetOrderReply);`
