---
title: Use Short, Idiomatic Identifier Names
impact: HIGH
impactDescription: reduces noise and matches Go conventions
tags: go, naming, style
---

## Use Short, Idiomatic Identifier Names

Prefer short names, MixedCaps, and consistent initialisms (ID, URL, HTTP). Receiver names should be short and consistent.

**Incorrect (non-idiomatic casing):**

```go
type UserId string

func (User) GetURL() string { ... }
```

**Correct (MixedCaps and initialisms):**

```go
type UserID string

func (u User) URL() string { ... }
```

Reference: https://go.dev/doc/effective_go
