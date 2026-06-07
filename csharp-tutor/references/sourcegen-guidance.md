# Source Generator Guidance

Use this reference for C# source generators, incremental generators, generated code review, and generator testing.

## Prefer Incremental Generators

For new work, prefer `IIncrementalGenerator` over classic generators. Keep pipeline steps small, deterministic, and cache-friendly.

## Design Priorities

- Generate code from explicit user intent, such as attributes, marker types, or known configuration.
- Avoid scanning more syntax than needed.
- Use semantic models only after filtering syntax candidates.
- Emit stable generated names and deterministic output.
- Report diagnostics with actionable messages and precise locations.
- Keep generated code readable enough for debugging.
- Avoid hidden runtime behavior that users cannot inspect.

## Testing

Generator tests should verify:

- Generated source for representative inputs.
- Diagnostics for invalid inputs.
- Incremental behavior when inputs change.
- Nullable annotations and accessibility.
- Compatibility with target frameworks and analyzer packaging.

## AOT And Serialization

Source generation is often useful for AOT and trimming because it can replace runtime reflection. For `System.Text.Json`, separate serializer source-generation configuration from general-purpose Roslyn generator design.

## Common Risks

- Expensive semantic analysis on every syntax node.
- Generated code that depends on unstable ordering.
- Diagnostics with no location or unclear remediation.
- Missing tests for invalid user code.
- Package layout that works locally but fails as an analyzer dependency.
