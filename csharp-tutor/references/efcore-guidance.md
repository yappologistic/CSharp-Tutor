# EF Core Guidance

Use this reference for Entity Framework Core questions, reviews, and refactors.

## First Checks

- Identify EF Core version, provider, target framework, DbContext lifetime, migration setup, and whether lazy loading is enabled.
- Inspect entity relationships, query shape, tracking behavior, transactions, indexes, concurrency handling, and raw SQL usage.
- Verify provider-specific or version-sensitive claims against current Microsoft EF Core docs.

## Review Priorities

1. Query correctness and server translation.
2. Tracking versus no-tracking behavior.
3. N plus one risks, lazy loading surprises, and unnecessary Include chains.
4. Projection shape for reads instead of loading full graphs by default.
5. Migration safety, required indexes, constraints, and schema drift.
6. Transaction boundaries and optimistic concurrency handling.
7. Raw SQL parameterization and untrusted input handling.
8. DbContext lifetime and async usage.

## Common Feedback

- Use projections for read models when the caller does not need tracked entities.
- Use `AsNoTracking` for read-only queries when tracking is not needed.
- Avoid client-side methods inside queries unless translation is known and intentional.
- Avoid long-lived DbContext instances; scope them to a unit of work.
- Use async EF APIs for I/O-bound web and service code.
- Treat raw SQL as injection-sensitive and parameterize values.
- Benchmark or inspect generated SQL before claiming a query is faster.

## Teaching Style

Explain EF Core as a unit-of-work plus query translator plus change tracker. For learners, separate LINQ-to-Objects behavior from LINQ-to-Entities behavior because translation changes what code is valid and performant.
