---
title: Use const and iota for Enumerations
impact: MEDIUM
impactDescription: improves clarity and type safety
tags: go, initialization, constants
---

## Use const and iota for Enumerations

Use `const` with `iota` to define related values, and type them when appropriate.

**Incorrect (magic numbers):**

```go
const (
	statusNew = 1
	statusDone = 2
)
```

**Correct (typed iota):**

```go
type Status int

const (
	StatusNew Status = iota
	StatusDone
)
```

Reference: https://go.dev/doc/effective_go
