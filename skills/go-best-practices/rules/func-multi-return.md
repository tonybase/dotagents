---
title: Return Multiple Values with error Last
impact: HIGH
impactDescription: standard Go error handling
tags: go, functions, errors
---

## Return Multiple Values with error Last

Go uses multiple return values to return results plus errors. The error is conventionally the last result.

**Incorrect (panic for expected errors):**

```go
func ReadConfig(path string) Config {
	b, err := os.ReadFile(path)
	if err != nil {
		panic(err)
	}
	return parseConfig(b)
}
```

**Correct (return error last):**

```go
func ReadConfig(path string) (Config, error) {
	b, err := os.ReadFile(path)
	if err != nil {
		return Config{}, err
	}
	return parseConfig(b), nil
}
```

Reference: https://go.dev/doc/effective_go
