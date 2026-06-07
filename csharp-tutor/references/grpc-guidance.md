# gRPC Guidance

Use this reference for .NET gRPC contracts, services, clients, streaming, and production review.

## First Questions

- Is this unary, server streaming, client streaming, or bidirectional streaming?
- What are the `.proto` contracts and package/service names?
- What deadlines, cancellation behavior, retries, and error semantics are expected?
- Is this internal service-to-service traffic, public API traffic, or browser-accessed gRPC-Web?

## Review Priorities

- Treat `.proto` files as public contracts once clients depend on them.
- Preserve field numbers and avoid incompatible type changes.
- Use deadlines and cancellation tokens on clients and services.
- Map expected failures to appropriate gRPC status codes.
- Avoid leaking internal exception details through status messages.
- Validate metadata and auth server-side.
- For streaming, plan backpressure, cancellation, message size, and reconnect behavior.
- Add integration tests around contract compatibility and error mapping.

## Common Risks

- Reusing persistence entities as wire contracts.
- Changing field numbers or removing fields without compatibility planning.
- Missing deadlines causing hung calls under partial outages.
- Treating gRPC status codes like HTTP status codes without mapping semantics.
- Assuming gRPC-Web behaves exactly like native gRPC.

## Output Pattern

For reviews, lead with contract compatibility and runtime behavior:

```text
Contract risk: ...
Runtime risk: ...
Fix: ...
Check: ...
```
