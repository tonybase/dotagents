---
title: Write Doc Comments as Full Sentences
impact: MEDIUM
impactDescription: improves readability and godoc output
tags: go, comments, documentation
---

## Write Doc Comments as Full Sentences

Exported declarations should have doc comments that start with the name and read as complete sentences.

**Incorrect (fragment, missing name):**

```go
// returns the current user.
func CurrentUser() *User { ... }
```

**Correct (starts with name, full sentence):**

```go
// CurrentUser returns the authenticated user.
func CurrentUser() *User { ... }
```

For packages, use `Package <name> ...` in the package comment.

Reference: https://go.dev/doc/effective_go
