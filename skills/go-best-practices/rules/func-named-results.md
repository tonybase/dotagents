---
title: Use Named Result Parameters Sparingly
impact: MEDIUM
impactDescription: improves clarity for simple functions
tags: go, functions, readability
---

## Use Named Result Parameters Sparingly

Named results can clarify intent for short functions, but avoid them in long or complex functions where they obscure control flow.

**Incorrect (named results hide return values):**

```go
func parsePort(s string) (port int, err error) {
	port, err = strconv.Atoi(s)
	if err != nil {
		return
	}
	if port <= 0 {
		err = errors.New("invalid port")
		return
	}
	return
}
```

**Correct (explicit returns):**

```go
func parsePort(s string) (int, error) {
	port, err := strconv.Atoi(s)
	if err != nil {
		return 0, err
	}
	if port <= 0 {
		return 0, errors.New("invalid port")
	}
	return port, nil
}
```

Reference: https://go.dev/doc/effective_go
