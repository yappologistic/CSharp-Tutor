# Output Quality Tests

This folder contains golden prompts and rubrics for C# Tutor answer quality.

`golden-qa.json` is the source of truth. Each case defines:

- a representative prompt,
- expected key points,
- phrases that should not appear in a good answer,
- a short human-review rubric,
- the minimum number of key points required when a captured answer is scored.

Run the structural check:

```powershell
.\scripts\test-output-quality.ps1
```

To semi-automatically score real model outputs, save each captured answer as:

```text
tests\answers\<case-id>.md
```

Then run:

```powershell
.\scripts\test-output-quality.ps1 -AnswersRoot .\tests\answers
```

This is intentionally a key-point gate, not a claim that keyword matching proves answer correctness. It catches obvious omissions and bad claims, then leaves the rubric for human review.
