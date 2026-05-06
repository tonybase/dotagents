---
title: Use Map Idioms with comma-ok
impact: HIGH
impactDescription: avoids nil map panics and missing key bugs
tags: go, data, maps
---

## Use Map Idioms with comma-ok

Maps return the zero value for missing keys. Use the comma-ok idiom when presence matters.

**Incorrect (can't distinguish missing key):**

```go
count := counts[name]
if count == 0 {
	// missing or explicitly zero?
}
```

**Correct (comma-ok):**

```go
count, ok := counts[name]
if !ok {
	// missing key
}
```

Remember to `make` maps before writing to them.

Reference: https://go.dev/doc/effective_go
