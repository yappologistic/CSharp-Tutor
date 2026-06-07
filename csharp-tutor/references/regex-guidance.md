# Regex Guidance

Use this reference for C# regular expression writing, debugging, replacement, and review.

## Ask For Examples

When missing, ask for:

- Strings that should match.
- Strings that should not match.
- Desired captures or replacement output.
- Whether matching should be culture-sensitive, case-insensitive, multiline, or singleline.

## C# Specifics

- Prefer verbatim strings for many patterns: `@"\d+"`.
- Escape differently in normal strings and verbatim strings.
- Use named groups when captures are consumed by code.
- Set a timeout for patterns that run on untrusted or large input.
- Consider `RegexOptions.Compiled` only for reused patterns where startup cost is acceptable.
- Consider source-generated regex for static, frequently used patterns in modern .NET.

## Safety And Performance

- Watch for catastrophic backtracking from nested quantifiers.
- Prefer anchors and clear character classes.
- Avoid using regex for full parsers when a structured parser is more reliable.
- Add table-driven tests for representative inputs.

## Output Shape

For pattern requests:

```text
Pattern:
...

C# usage:
...

Matches:
- ...

Does not match:
- ...
```

Explain only the important tokens unless the user asks for a full walkthrough.
