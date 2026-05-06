---
title: Wrap Errors with Context
impact: HIGH
impactDescription: improves debuggability while preserving causes
tags: go, errors, wrapping
---

## Wrap Errors with Context

Add context when returning errors and preserve the original error for inspection.

**Incorrect (loses context):**

```go
if err := writeFile(path); err != nil {
	return err
}
```

**Correct (wrap with context):**

```go
if err := writeFile(path); err != nil {
	return fmt.Errorf("write %s: %w", path, err)
}
```

Use `errors.Is` or `errors.As` to check wrapped errors.

Reference: https://go.dev/doc/effective_go
