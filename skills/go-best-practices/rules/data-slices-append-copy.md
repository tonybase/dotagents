---
title: Understand Slice Sharing, append, and copy
impact: HIGH
impactDescription: avoids unexpected mutations and memory retention
tags: go, data, slices
---

## Understand Slice Sharing, append, and copy

Slices share underlying arrays. Use `append` to grow and `copy` to make independent data.

**Incorrect (shared backing array mutates original):**

```go
orig := []int{1, 2, 3, 4}
sub := orig[:2]
sub[0] = 99
// orig is now [99 2 3 4]
```

**Correct (copy to isolate):**

```go
orig := []int{1, 2, 3, 4}
sub := make([]int, 2)
copy(sub, orig[:2])
sub[0] = 99
// orig remains [1 2 3 4]
```

Reference: https://go.dev/doc/effective_go
