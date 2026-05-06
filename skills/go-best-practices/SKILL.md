---
name: go-best-practices
description: Idiomatic Go best practices distilled from Effective Go. Use when writing, reviewing, or refactoring Go code for formatting, naming, control flow, functions, data structures, initialization, methods/interfaces, concurrency, and error handling. Triggers include "Effective Go", "Go best practices", "idiomatic Go", or "Go style".
---

# Go Best Practices

Concise, idiomatic Go guidelines summarized from the Effective Go document. Each rule focuses on correctness, readability, and maintainability for everyday Go code.

## Rule Categories

| Category | Focus | Prefix |
| --- | --- | --- |
| Formatting and Commentary | gofmt, comments, documentation style | `format-` |
| Names and Packages | identifier style, package naming | `name-` |
| Control Structures | if/for/switch, range, short statements | `control-` |
| Functions and Defer | return values, named results, defer usage | `func-` |
| Data and Allocation | new vs make, slices, literals, maps | `data-` |
| Initialization | constants, variables, init | `init-` |
| Methods and Interfaces | receivers, interface design, embedding | `method-` |
| Concurrency | goroutines, channels, select | `concurrency-` |
| Errors | error values, wrapping, panic/recover | `error-` |

## Quick Reference

### Formatting and Commentary
- `format-gofmt` - Use gofmt and trust its formatting
- `format-comments` - Write doc comments as full sentences

### Names and Packages
- `name-identifiers` - Prefer short, clear names with MixedCaps
- `name-packages-getters` - Keep package names simple; avoid stutter; omit Get
- `name-blank-identifier` - Use `_` to ignore values explicitly
- `name-side-effect-imports` - Use blank imports only for side effects

### Control Structures
- `control-short-decl` - Use short statements in if/for/switch
- `control-range` - Prefer range for iteration
- `control-switch` - Use switch/type switch effectively

### Functions and Defer
- `func-multi-return` - Return values plus error as last
- `func-named-results` - Use named results sparingly and clearly
- `func-defer` - Use defer for cleanup and unlocking

### Data and Allocation
- `data-make-new` - Use make for slices/maps/channels; new rarely
- `data-composite-literals` - Prefer composite literals for clarity
- `data-slices-append-copy` - Understand slice sharing; use append/copy
- `data-maps` - Use map idioms and comma-ok checks

### Initialization
- `init-const-iota` - Use const and iota for enumerations
- `init-init-func` - Keep init small and deterministic

### Methods and Interfaces
- `method-receivers` - Choose pointer vs value receivers deliberately
- `method-small-interfaces` - Keep interfaces small; accept interfaces
- `method-embedding` - Use embedding for composition

### Concurrency
- `concurrency-communicate` - Share memory by communicating
- `concurrency-close-range` - Close channels from senders; range receivers
- `concurrency-select-timeout` - Use select for timeouts and cancellation

### Errors
- `error-values` - Treat errors as values
- `error-wrap-context` - Wrap errors with context and %w
- `error-panic-recover` - Use panic/recover only for programmer errors

## How to Use

Read individual rule files for detailed explanations and minimal examples:

```
rules/format-gofmt.md
rules/control-short-decl.md
rules/_sections.md
```

Each rule file contains:
- Brief explanation of why it matters
- Incorrect code example with explanation
- Correct code example with explanation
- Additional context and references

For the complete guide with all rules expanded: `AGENTS.md`

## Source

Primary source: https://go.dev/doc/effective_go
