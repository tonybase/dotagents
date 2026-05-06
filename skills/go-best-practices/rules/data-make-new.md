---
title: Use make for Slices, Maps, and Channels
impact: HIGH
impactDescription: prevents nil map/slice panics
tags: go, data, allocation
---

## Use make for Slices, Maps, and Channels

Use `make` to initialize slices, maps, and channels. `new` allocates zero values and is rarely needed for these types.

**Incorrect (nil map):**

```go
m := new(map[string]int)
(*m)["a"] = 1 // panic: assignment to entry in nil map
```

**Correct (make):**

```go
m := make(map[string]int)
m["a"] = 1
```

Reference: https://go.dev/doc/effective_go
