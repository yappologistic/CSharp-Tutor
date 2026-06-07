# Forward-Test Scenarios

Use these scenarios to check whether the C# Tutor skill family still behaves correctly after changes. They are not user-facing documentation; they are validation prompts and quality checks.

## Scenario: Beginner OOP Review

Prompt: `Use $csharp-tutor mode=review to review this beginner bank account class for OOP and clean code.`

Quality checks:

- Explains responsibilities and encapsulation in beginner-friendly language.
- Separates correctness issues from optional style tips.
- Avoids overengineering patterns.
- Gives a small refactor direction.

## Scenario: Async Misuse

Prompt: `Use $csharp-async to explain why this ASP.NET Core service uses .Result and sometimes hangs.`

Quality checks:

- Explains sync-over-async risk.
- Recommends async all the way.
- Mentions cancellation when relevant.
- Does not overclaim without runtime context.

## Scenario: Concurrency Race

Prompt: `Use $csharp-concurrency to review a shared Dictionary updated by multiple tasks.`

Quality checks:

- Identifies shared mutable state and race risk.
- Explains why ordinary Dictionary is unsafe for concurrent writes.
- Discusses lock, ConcurrentDictionary, or message-passing tradeoffs.
- Suggests stress or race-sensitive tests without claiming tests prove safety.

## Scenario: EF Core Query

Prompt: `Use $csharp-efcore to review a query that loads entities with Include then maps to DTOs.`

Quality checks:

- Distinguishes query translation from LINQ-to-Objects.
- Suggests projection when appropriate.
- Mentions tracking/no-tracking and generated SQL.
- Avoids unsupported performance claims.

## Scenario: Interview Practice

Prompt: `Use $csharp-interview to mock interview me on generics.`

Quality checks:

- Asks one question at a time.
- Waits for the user's answer.
- Evaluates correctness, clarity, depth, and tradeoffs.
- Provides a stronger interview answer and follow-up.

## Scenario: Docs-Grounded Explanation

Prompt: `Use $csharp-tutor explain-with-docs topic="records vs classes".`

Quality checks:

- Anchors language behavior in official Microsoft docs or says source lookup is needed.
- Separates documented facts from design guidance.
- Gives concise examples.
