---
title: Prefer range for Iteration
impact: MEDIUM
impactDescription: clearer loops and fewer indexing bugs
tags: go, control-flow, range
---

## Prefer range for Iteration

Use `for ... range` to iterate over slices, arrays, maps, and strings when you do not need the index.

**Incorrect (index when not needed):**

```go
for i := 0; i < len(names); i++ {
	fmt.Println(names[i])
}
```

**Correct (range):**

```go
for _, name := range names {
	fmt.Println(name)
}
```

Note: map iteration order is not deterministic.

Reference: https://go.dev/doc/effective_go
