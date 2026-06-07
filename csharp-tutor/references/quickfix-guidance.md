# Quick Fix Guidance

Use this reference when the user pastes one compiler error, runtime exception, nullable warning, analyzer warning, or small failing snippet and wants the smallest likely fix with minimal explanation.

## Scope

Quick fix is for narrow problems:

- One compiler diagnostic.
- One exception and a small snippet.
- One nullable or analyzer warning.
- One obvious build or syntax issue.

Use `csharp-debug` instead when the issue needs multi-step diagnosis, runtime state, logs, tests, project inspection, or several possible causes.

## Response Format

Keep the response short:

```text
Likely fix: <one sentence>

Change:
<small code or command>

Why: <one short sentence>
```

Add `Check:` only when there is a simple command or test that proves the fix.

## Rules

- Give the smallest safe fix first.
- Do not rewrite unrelated code.
- Do not provide a long tutorial unless the user asks.
- Say when the fix is a best guess because the snippet is incomplete.
- Preserve behavior unless the error requires a behavior change.
- Escalate to `csharp-debug` when the likely cause is uncertain.

## Common Fix Types

- Add a missing `using`.
- Fix a type mismatch or generic type argument.
- Add a null check or change `T` to `T?` when the contract is truly optional.
- Await a `Task` or make the calling method `async`.
- Replace `.Result` or `.Wait()` only when the pasted error or risk directly calls for it.
- Fix method signature, constructor arguments, accessibility, or namespace mismatch.
- Add a package reference only when the missing type clearly comes from that package.
