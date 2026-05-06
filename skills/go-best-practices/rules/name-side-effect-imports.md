---
title: Use Blank Imports for Side Effects Only
impact: MEDIUM
impactDescription: keeps imports honest and explicit
tags: go, imports, side-effects
---

## Use Blank Imports for Side Effects Only

Use a blank identifier import when you need a package's init side effects (such as driver registration).

**Incorrect (unused import):**

```go
import "database/sql"
import "github.com/lib/pq" // unused
```

**Correct (blank import for side effects):**

```go
import "database/sql"
import _ "github.com/lib/pq" // register driver
```

Reference: https://go.dev/doc/effective_go
