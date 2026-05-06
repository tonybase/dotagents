---
title: Close Channels from Senders and Range Receivers
impact: HIGH
impactDescription: prevents deadlocks and panics
tags: go, concurrency, channels
---

## Close Channels from Senders and Range Receivers

Only the sender should close a channel. Receivers should range until the channel is closed.

**Incorrect (receiver closes):**

```go
func worker(ch chan int) {
	for v := range ch {
		if v == 0 {
			close(ch) // unsafe: receiver closing
		}
	}
}
```

**Correct (sender closes):**

```go
func producer(ch chan<- int) {
	defer close(ch)
	for i := 0; i < 3; i++ {
		ch <- i
	}
}

func consumer(ch <-chan int) {
	for v := range ch {
		fmt.Println(v)
	}
}
```

Reference: https://go.dev/doc/effective_go
