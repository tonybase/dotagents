---
title: Share Memory by Communicating
impact: HIGH
impactDescription: avoids data races and simplifies synchronization
tags: go, concurrency, channels
---

## Share Memory by Communicating

Prefer channels and message passing over shared mutable state.

**Incorrect (shared mutable state without sync):**

```go
var count int

func inc() {
	count++
}
```

**Correct (channel-based update):**

```go
func counter(ch <-chan struct{}, done chan<- int) {
	count := 0
	for range ch {
		count++
	}
	done <- count
}
```

Reference: https://go.dev/doc/effective_go
