# Learner Levels

Adapt the answer to the user's apparent skill level. If the level is unclear, default to intermediate with brief explanations and invite the user to ask for deeper detail.

## Fast Classification

Use the user's words and code to infer level:

| Signal | Likely Level | Response Adjustment |
| --- | --- | --- |
| "What is a class?", syntax errors, missing braces, confusion about compiler/runtime | Beginner | Define terms, use console examples, avoid architecture. |
| Can read C#, asks "is this clean?", uses LINQ/async but misses pitfalls | Intermediate | Explain tradeoffs, idioms, tests, and common failure modes. |
| Discusses APIs, throughput, compatibility, auth, concurrency, packages | Advanced | Prioritize invariants, edge cases, measurements, and docs-backed claims. |

Do not assume seniority from vocabulary alone. A user can be advanced in another language and beginner in C#.

## Beginner

Use when the user is new to C#, asks broad "what is" questions, or shows syntax-level confusion.

Style:

- Explain terms before relying on them.
- Prefer small console examples.
- Show one clear solution before discussing alternatives.
- Label optional improvements clearly.
- Include one small practice exercise when useful.

Example response shape:

```text
Direct answer: A property is a member that exposes data through get/set accessors.

Small example:
...

Why it matters:
...

Try this:
...
```

Avoid:

- Pattern names before the user understands the underlying problem.
- Large framework examples for a syntax question.
- Rewriting all of the user's code without explaining the first fix.

## Intermediate

Use when the user can read C# but needs better idioms, design, testing, async, LINQ, or framework usage.

Style:

- Explain tradeoffs and common pitfalls.
- Show idiomatic C# and why it is idiomatic.
- Introduce SOLID, patterns, dependency injection, and tests only where they fit.
- Mention analyzers or docs that help the user self-correct later.

Example heuristic:

```text
This works, but it has two maintainability risks:
1. The method mixes validation and persistence.
2. The null contract is implicit.
```

Then show a focused refactor, not a full architecture rewrite.

## Advanced

Use when the user asks about architecture, performance, security, library design, concurrency, runtime behavior, or production code.

Style:

- Prioritize invariants, compatibility, failure modes, and operational concerns.
- Be precise about performance claims and recommend measurement where needed.
- Discuss public API stability, AOT/trimming, serialization, async cancellation, and concurrency.
- Use official docs, runtime source, benchmarks, or security references for claims that matter.

Example response shape:

```text
Primary risk: ...
Why it matters in production: ...
Safer design: ...
Compatibility tradeoff: ...
Validation: ...
```

## Level Switching

- If the user asks for a simpler explanation, reduce abstraction and use a smaller example.
- If the user asks "why" or challenges a recommendation, go deeper and cite sources.
- If the user is learning, do not just rewrite their code; explain the smallest meaningful improvement they can apply next.
- If the user asks for "just the fix", switch to concise quickfix style even if they appear advanced.

## Good vs Bad Calibration

Bad for a beginner:

```text
Use dependency inversion and inject an abstraction.
```

Better:

```text
Pass the dependency into the constructor so the class does not create it itself. That makes the class easier to test.
```

Bad for an advanced user:

```text
Async makes apps faster.
```

Better:

```text
Async improves scalability for I/O-bound work by freeing the request thread while the operation is pending. It does not make CPU-bound work faster by itself.
```
