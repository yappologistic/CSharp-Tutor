# Review Profiles

Use this reference when the user provides `profile=...`, asks for a specific review style, or when the goal implies a profile.

## Profiles

### `profile=beginner`

- Explain terms before using them.
- Limit feedback to the highest-impact issues.
- Separate required fixes from optional tips.
- Include one small practice step.

### `profile=production`

- Prioritize correctness, security, observability, failure handling, configuration, scalability, performance, and tests.
- Include verification commands or test ideas.
- Call out assumptions and deployment/runtime risks.

### `profile=architecture`

- Prioritize responsibilities, dependency direction, boundaries, coupling, cohesion, DTO/entity separation, and incremental refactors.
- Avoid pattern names unless the pattern solves a concrete problem.

### `profile=security`

- Prioritize untrusted input, auth/authz, injection, file paths, serialization, secrets, logging, cryptography, dependency risk, and secure defaults.
- Distinguish confirmed vulnerabilities from possible risks.

### `profile=performance`

- Prioritize hot paths, allocations, data structures, async scalability, database queries, serialization, memory pressure, and measurement.
- Avoid claiming speedups without reasoning, generated SQL, benchmark results, or official guidance.

### `profile=interview`

- Focus on explaining the concept clearly out loud.
- Mention common follow-up questions.
- Provide a stronger interview-style answer after feedback.

## Output Rule

Honor the requested profile without ignoring correctness or safety. If multiple profiles are requested, order findings by the highest-risk profile first.
