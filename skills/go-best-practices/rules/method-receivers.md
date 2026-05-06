---
title: Choose Pointer vs Value Receivers Deliberately
impact: HIGH
impactDescription: avoids unintended copies and enables mutation
tags: go, methods, receivers
---

## Choose Pointer vs Value Receivers Deliberately

Use pointer receivers when methods mutate state or when the type is large. Use value receivers for small, immutable types.

**Incorrect (value receiver mutates a copy):**

```go
type Counter struct { n int }

func (c Counter) Inc() { c.n++ }
```

**Correct (pointer receiver):**

```go
func (c *Counter) Inc() { c.n++ }
```

Keep receiver choice consistent across methods on the same type.

Reference: https://go.dev/doc/effective_go
