# Modernization Map

Use this map when the user asks to refactor C# with newer language or .NET features, or when a review reveals a clear modernization opportunity.

Always confirm or infer the target C# and .NET version before recommending a feature. Verify version availability with Microsoft docs.

## Common Refactors

| Older Pattern | Consider | Use When |
| --- | --- | --- |
| DTO classes with value semantics | `record` or `record struct` | The type is mostly immutable data and equality by value is useful. |
| Mutable required properties | `required` members or constructor validation | The object must not exist in an incomplete state. |
| Verbose null checks | Nullable annotations, `ArgumentNullException.ThrowIfNull`, pattern checks | The project has nullable reference types enabled or can adopt them. |
| Long `switch` statements returning values | Switch expressions and patterns | The mapping is expression-like and remains readable. |
| Type checks and casts | Pattern matching | Branches depend on runtime shape or values. |
| Manual collection setup | Collection expressions or collection initializers | The target language version supports them and readability improves. |
| Tuple-like helper classes | Records, tuples, or small named types | The result shape is data-oriented and simple. |
| Event/callback/task continuation code | `async`/`await` | The flow is asynchronous and exception/cancellation behavior should be clearer. |
| Manual disposal in `try/finally` | `using` declarations or `await using` | The object implements `IDisposable` or `IAsyncDisposable`. |
| Manual string concatenation in loops | `StringBuilder`, interpolation, `string.Create`, spans | The code is hot, large, or allocation-sensitive. |
| `DateTime.Now` for cross-zone logic | `DateTimeOffset`, `TimeProvider`, explicit UTC handling | Time crosses machine, user, service, or test boundaries. |
| Hand-written argument validation | Guard clauses and built-in throw helpers | The method has clear preconditions. |
| Reflection-heavy repeated work | Source generators or cached compiled delegates | The path is hot and complexity is justified. |
| Sync I/O in server code | Async APIs with cancellation | Throughput, responsiveness, or resource usage matters. |

## Modernization Guardrails

- Do not modernize for novelty. Prefer the clearest version for the user's team and target runtime.
- Show before-and-after code when changing syntax or structure.
- Explain the practical gain: correctness, safety, readability, performance, testability, or maintainability.
- Mention compatibility costs, especially language version, target framework, analyzers, serializers, ORMs, and team familiarity.
- Keep beginner examples simple even if newer syntax exists.

## Feature Verification

Before suggesting a specific feature, verify:

- Minimum C# language version.
- Minimum .NET target framework or package version, if relevant.
- Whether project settings enable nullable reference types, implicit usings, analyzers, or preview features.
- Whether the feature affects serialization, ORM mapping, source generation, trimming, AOT, or public API compatibility.
