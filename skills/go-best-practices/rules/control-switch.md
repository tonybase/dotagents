---
title: Use switch and Type Switch for Clarity
impact: MEDIUM
impactDescription: reduces nested if/else and clarifies intent
tags: go, control-flow, switch
---

## Use switch and Type Switch for Clarity

Prefer `switch` over long if/else chains. Use type switches when branching on interface types.

**Incorrect (nested if/else):**

```go
if status == 400 {
	msg = "bad request"
} else if status == 404 {
	msg = "not found"
} else {
	msg = "unknown"
}
```

**Correct (switch):**

```go
switch status {
case 400:
	msg = "bad request"
case 404:
	msg = "not found"
default:
	msg = "unknown"
}
```

Type switch example:

```go
switch v := anyValue.(type) {
case string:
	fmt.Println("string", v)
case int:
	fmt.Println("int", v)
default:
	fmt.Printf("other %T\n", v)
}
```

Reference: https://go.dev/doc/effective_go
