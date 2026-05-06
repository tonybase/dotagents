---
title: Keep Interfaces Small and Focused
impact: HIGH
impactDescription: increases flexibility and reuse
tags: go, interfaces, design
---

## Keep Interfaces Small and Focused

Prefer small interfaces that describe a single behavior. Accept interfaces, return concrete types.

**Incorrect (large interface):**

```go
type Store interface {
	Get(id string) (Item, error)
	Put(item Item) error
	Delete(id string) error
	List() ([]Item, error)
}
```

**Correct (small interfaces):**

```go
type Getter interface {
	Get(id string) (Item, error)
}

type Putter interface {
	Put(item Item) error
}
```

Reference: https://go.dev/doc/effective_go
