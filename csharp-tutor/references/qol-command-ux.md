# Command UX Quality Of Life

Use this reference when parsing `$csharp-tutor` hints, aliases, answer length, output format, reveal behavior, or help output.

## Aliases

Treat these as equivalent routing hints:

- `q` or `quick`: `depth=quick`
- `quiz`: practice questions or interview-style drills
- `fix`: debug or review depending on whether code/error is provided
- `docs`: `mode=docs`
- `lab`: `mode=debug-lab`
- `cs`: `mode=cheatsheet`
- `sheet` or `cheatsheet`: `mode=cheatsheet`
- `next`: recommend what to learn next

Do not require exact syntax. Natural language always wins over aliases when intent is clear.

## Depth Hints

- `depth=quick`: direct answer, one example if needed, minimal caveats.
- `depth=normal`: direct answer, explanation, example, common mistake, optional tip.
- `depth=deep`: full mental model, examples, edge cases, tradeoffs, verification, and practice.

## Format Hints

- `format=findings`: review findings ordered by severity.
- `format=before-after`: show original problem and improved version.
- `format=checklist`: concise checklist.
- `format=mentor`: teach with explanation and next step.
- `format=table`: compact comparison table when it helps.
- `format=compact`: shortest useful structured answer.
- `format=examples`: emphasize examples over theory.
- `format=mistakes`: emphasize common mistakes and fixes.
- `format=interview`: shape the answer as interview prep.

## Scope Hints

For reviews, honor `scope=correctness|security|performance|architecture|tests|all`.

Default to `scope=all` for open-ended code review, but keep severe correctness and security findings visible even when another scope is requested.

## Difficulty Hints

- `difficulty=easy`: one concept, small code, obvious symptom.
- `difficulty=medium`: two related concepts or a realistic trap.
- `difficulty=hard`: multi-step diagnosis, edge cases, or production-like constraints.
- `next_difficulty=true`: increase difficulty by one level after the learner succeeds; decrease if they struggle.

## Reveal Control

- `reveal=false`: for labs, quizzes, and practice, withhold the solution and give hints first.
- `reveal=true`: include solution after the exercise.
- If unspecified in debug labs, default to `reveal=false`.

## Confidence Labels

- `confidence=docs-verified`: official docs/source were checked.
- `confidence=inferred`: answer is reasoned from general C#/.NET knowledge.
- `confidence=needs-project-context`: project settings are needed to be precise.

Do not overstate confidence when docs or project context were not checked.

## Paste-Friendly Code

- `pasteable=true`: include required usings, minimal wrapper, supporting types, and expected output when appropriate.
- `pasteable=false`: snippets may be partial when brevity is more important.

## Project-Aware Defaults

If a path to a `.csproj`, `.sln`, or repo appears, inspect project configuration before recommending version-sensitive features, analyzers, packages, EF Core patterns, ASP.NET Core patterns, or modernization.

## Help Output

For help requests, show only:

1. Most useful modes.
2. Common aliases.
3. Profiles, depth, and format hints.
4. Three to six examples.

Offer the full command index only if the user asks.
