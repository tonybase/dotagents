---
title: Use panic and recover Only for Programmer Errors
impact: HIGH
impactDescription: keeps normal errors explicit and controllable
tags: go, errors, panic
---

## Use panic and recover Only for Programmer Errors

Reserve `panic` for unrecoverable programmer mistakes. Recover at boundaries (e.g., server handlers) to convert to errors.

**Incorrect (panic for expected errors):**

```go
if err := validate(input); err != nil {
	panic(err)
}
```

**Correct (return error; recover at boundary):**

```go
if err := validate(input); err != nil {
	return err
}

// boundary
func handler(w http.ResponseWriter, r *http.Request) {
	defer func() {
		if rec := recover(); rec != nil {
			http.Error(w, "internal error", http.StatusInternalServerError)
		}
	}()
	// ...
}
```

Reference: https://go.dev/doc/effective_go
