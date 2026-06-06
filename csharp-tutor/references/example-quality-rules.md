# Example Quality Rules

Use this reference before providing C# code examples, especially for learners.

## Runnable Defaults

- Prefer copy-paste runnable examples for beginner and normal-depth answers.
- Include required `using` statements when they are not obvious.
- Include all small supporting types needed to understand the example.
- Show expected output for console examples when useful.
- Keep examples focused; do not build a whole app for a small concept.

## Pasteable Mode

When `pasteable=true`:

- Include all necessary `using` statements.
- Include a minimal `Program` or class wrapper for console examples.
- Include supporting types in the same snippet.
- Include expected output when the example prints output.
- Avoid ellipses and "assume this exists" placeholders unless the dependency is the user's provided code.

## Version-Aware Examples

- Avoid newer syntax for beginners unless teaching that syntax.
- Mention the required C#/.NET version for version-sensitive features.
- If project context is available, match its target framework and language version.
- If context is missing, choose broadly compatible syntax or state the assumption.

## Correctness Checks

- Do not include code that contradicts the explanation.
- Avoid hidden dependencies, uninitialized state, or ambiguous names.
- For async examples, show `await` correctly and pass cancellation where relevant.
- For EF Core examples, distinguish illustrative snippets from fully configured runnable apps.
- For security examples, avoid unsafe shortcuts unless explicitly labeled as unsafe.
