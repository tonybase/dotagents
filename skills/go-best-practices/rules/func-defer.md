---
title: Use defer for Cleanup
impact: HIGH
impactDescription: ensures cleanup on all return paths
tags: go, functions, defer
---

## Use defer for Cleanup

Call `defer` immediately after acquiring a resource to guarantee cleanup, even on errors.

**Incorrect (forgot to close on early return):**

```go
f, err := os.Open(path)
if err != nil {
	return err
}
if err := doWork(f); err != nil {
	return err
}
return f.Close()
```

**Correct (defer right after open):**

```go
f, err := os.Open(path)
if err != nil {
	return err
}
defer f.Close()

if err := doWork(f); err != nil {
	return err
}
return nil
```

Reference: https://go.dev/doc/effective_go
