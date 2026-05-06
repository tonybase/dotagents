---
title: Use Short Statements in Control Flow
impact: MEDIUM-HIGH
impactDescription: keeps scopes tight and error handling local
tags: go, control-flow, style
---

## Use Short Statements in Control Flow

Use short declarations in `if`, `for`, and `switch` to keep variables scoped to the control block.

**Incorrect (wider scope than needed):**

```go
f, err := os.Open(path)
if err != nil {
	return err
}
defer f.Close()
```

**Correct (scoped to the if block):**

```go
if f, err := os.Open(path); err != nil {
	return err
} else {
	defer f.Close()
}
```

Reference: https://go.dev/doc/effective_go
