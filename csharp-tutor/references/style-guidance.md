# C# Style Guidance

Use this reference for naming conventions, formatting, `.editorconfig`, analyzers, and idiomatic C# style.

## Naming

- Use PascalCase for public types, methods, properties, events, namespaces, and enum members.
- Use camelCase for local variables and parameters.
- Use `_camelCase` for private fields when that matches the project style.
- Use `I` prefix for interfaces, such as `IAccountRepository`.
- Use clear domain names over type-heavy names, such as `transactionHistory` instead of `transactionList`.
- Avoid abbreviations unless they are standard in the domain.

## Formatting and Style

- Follow the existing project's `.editorconfig` when present.
- Prefer clarity over clever syntax.
- Keep methods small enough to explain their responsibility in one sentence.
- Use expression-bodied members only when readability improves.
- Use `var` when the right side makes the type obvious; use explicit types when clarity improves.
- Keep comments for intent, invariants, and tricky tradeoffs; avoid comments that repeat the code.

## Idiomatic C#

- Prefer properties over public fields.
- Prefer `IReadOnlyList<T>` or `IEnumerable<T>` for read-only exposure when mutation should stay internal.
- Prefer guard clauses for invalid inputs.
- Prefer `StringComparison` for non-linguistic string comparisons.
- Prefer nullable annotations and clear contracts over defensive guessing.

## Tooling

- Use `.editorconfig` to make naming, formatting, and analyzer severity explicit.
- Use `dotnet format` for consistent formatting.
- Treat style rules as team/project conventions, not universal correctness.
