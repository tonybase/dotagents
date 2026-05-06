---
title: Keep Package Names Simple and Avoid Get
impact: HIGH
impactDescription: prevents stutter and improves API ergonomics
tags: go, naming, packages
---

## Keep Package Names Simple and Avoid Get

Package names should be short, lowercase, and not repeated in exported identifiers. Getter methods typically omit the "Get" prefix.

**Incorrect (stutter and Get prefix):**

```go
package userprofile

type UserProfile struct { ... }

func (p UserProfile) GetName() string { return p.name }
```

**Correct (no stutter, no Get):**

```go
package profile

type Profile struct { name string }

func (p Profile) Name() string { return p.name }
```

Reference: https://go.dev/doc/effective_go
