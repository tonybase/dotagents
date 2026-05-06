---
title: Use gofmt for Formatting
impact: HIGH
impactDescription: ensures standard formatting and tooling compatibility
tags: go, formatting, gofmt
---

## Use gofmt for Formatting

Let gofmt handle spacing, alignment, and semicolons. It produces the canonical style that every Go tool expects.

**Incorrect (manual alignment and inconsistent spacing):**

```go
if x>0{
    fmt.Println( "ok" )
}
```

**Correct (gofmt style):**

```go
if x > 0 {
	fmt.Println("ok")
}
```

Reference: https://go.dev/doc/effective_go
