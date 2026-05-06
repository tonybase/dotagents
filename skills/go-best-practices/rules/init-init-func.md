---
title: Keep init Small and Deterministic
impact: MEDIUM
impactDescription: avoids hidden side effects and ordering issues
tags: go, initialization, init
---

## Keep init Small and Deterministic

Use `init` only for setup that cannot be expressed with variable initialization. Avoid heavy side effects and external dependencies.

**Incorrect (hidden side effects):**

```go
func init() {
	cfg = loadRemoteConfig() // network call during init
}
```

**Correct (explicit initialization):**

```go
func Load() error {
	cfg = loadRemoteConfig()
	return nil
}
```

Reference: https://go.dev/doc/effective_go
