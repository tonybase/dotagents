---
title: Use the Blank Identifier to Ignore Values
impact: MEDIUM
impactDescription: avoids unused variable errors while keeping intent clear
tags: go, naming, blank-identifier
---

## Use the Blank Identifier to Ignore Values

Use `_` to ignore values you do not need. This keeps code explicit and avoids unused variable errors.

**Incorrect (unused variable):**

```go
v, err := strconv.Atoi(s)
if err != nil {
	return err
}
// v is unused
```

**Correct (ignore with _):**

```go
_, err := strconv.Atoi(s)
if err != nil {
	return err
}
```

Reference: https://go.dev/doc/effective_go
