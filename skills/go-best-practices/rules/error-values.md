---
title: Treat Errors as Values
impact: HIGH
impactDescription: enables explicit and consistent error handling
tags: go, errors, style
---

## Treat Errors as Values

Errors are ordinary values. Return them and handle them explicitly.

**Incorrect (silent failure):**

```go
_ = doWork()
```

**Correct (handle the error):**

```go
if err := doWork(); err != nil {
	return err
}
```

Reference: https://go.dev/doc/effective_go
