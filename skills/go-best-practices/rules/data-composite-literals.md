---
title: Prefer Composite Literals for Clarity
impact: MEDIUM
impactDescription: makes initialization explicit and stable
tags: go, data, literals
---

## Prefer Composite Literals for Clarity

Use composite literals to initialize structs, arrays, and maps. Use keyed fields for long or exported structs to avoid order bugs.

**Incorrect (positional fields are brittle):**

```go
type Server struct {
	Host string
	Port int
}

s := Server{"localhost", 8080}
```

**Correct (keyed literal):**

```go
s := Server{
	Host: "localhost",
	Port: 8080,
}
```

Reference: https://go.dev/doc/effective_go
