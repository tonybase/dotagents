---
title: Use Embedding for Composition
impact: MEDIUM-HIGH
impactDescription: promotes reuse without inheritance
tags: go, embedding, composition
---

## Use Embedding for Composition

Embed types to reuse behavior and promote methods without creating inheritance hierarchies.

**Incorrect (manual forwarding):**

```go
type Logger struct { ... }

type Service struct {
	log Logger
}

func (s *Service) Info(msg string) {
	s.log.Info(msg)
}
```

**Correct (embedding):**

```go
type Logger struct { ... }

type Service struct {
	Logger
}

// Service now has Logger's methods.
```

Reference: https://go.dev/doc/effective_go
