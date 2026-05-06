---
title: Use select for Timeouts and Cancellation
impact: HIGH
impactDescription: prevents goroutine leaks and unbounded waits
tags: go, concurrency, select
---

## Use select for Timeouts and Cancellation

Use `select` with `time.After` or `context` to avoid blocking forever on channels.

**Incorrect (can block forever):**

```go
v := <-ch
fmt.Println(v)
```

**Correct (timeout with select):**

```go
select {
case v := <-ch:
	fmt.Println(v)
case <-time.After(500 * time.Millisecond):
	return errors.New("timeout")
}
```

Reference: https://go.dev/doc/effective_go
