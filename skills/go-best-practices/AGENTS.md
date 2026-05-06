# Go Best Practices

**Version 1.0.0**  
The Go Authors  
March 2025

> **Note:**  
> This document is mainly for agents and LLMs to follow when writing, reviewing,  
> or refactoring Go code. Humans may also find it useful, but guidance here is  
> optimized for automation and consistency.

---

## Abstract

Concise, idiomatic Go guidelines distilled from Effective Go. Contains 27 rules across 9 categories, covering formatting, naming, control flow, functions, data structures, initialization, methods and interfaces, concurrency, and error handling.

---

## Table of Contents

1. [Formatting and Commentary](#1-formatting-and-commentary) - **HIGH**
   - 1.1 [Use gofmt for Formatting](#11-use-gofmt-for-formatting)
   - 1.2 [Write Doc Comments as Full Sentences](#12-write-doc-comments-as-full-sentences)
2. [Names and Packages](#2-names-and-packages) - **HIGH**
   - 2.1 [Use Short, Idiomatic Identifier Names](#21-use-short-idiomatic-identifier-names)
   - 2.2 [Keep Package Names Simple and Avoid Get](#22-keep-package-names-simple-and-avoid-get)
   - 2.3 [Use the Blank Identifier to Ignore Values](#23-use-the-blank-identifier-to-ignore-values)
   - 2.4 [Use Blank Imports for Side Effects Only](#24-use-blank-imports-for-side-effects-only)
3. [Control Structures](#3-control-structures) - **MEDIUM-HIGH**
   - 3.1 [Use Short Statements in Control Flow](#31-use-short-statements-in-control-flow)
   - 3.2 [Prefer range for Iteration](#32-prefer-range-for-iteration)
   - 3.3 [Use switch and Type Switch for Clarity](#33-use-switch-and-type-switch-for-clarity)
4. [Functions and Defer](#4-functions-and-defer) - **MEDIUM-HIGH**
   - 4.1 [Return Multiple Values with error Last](#41-return-multiple-values-with-error-last)
   - 4.2 [Use Named Result Parameters Sparingly](#42-use-named-result-parameters-sparingly)
   - 4.3 [Use defer for Cleanup](#43-use-defer-for-cleanup)
5. [Data and Allocation](#5-data-and-allocation) - **HIGH**
   - 5.1 [Use make for Slices, Maps, and Channels](#51-use-make-for-slices-maps-and-channels)
   - 5.2 [Prefer Composite Literals for Clarity](#52-prefer-composite-literals-for-clarity)
   - 5.3 [Understand Slice Sharing, append, and copy](#53-understand-slice-sharing-append-and-copy)
   - 5.4 [Use Map Idioms with comma-ok](#54-use-map-idioms-with-comma-ok)
6. [Initialization](#6-initialization) - **MEDIUM**
   - 6.1 [Use const and iota for Enumerations](#61-use-const-and-iota-for-enumerations)
   - 6.2 [Keep init Small and Deterministic](#62-keep-init-small-and-deterministic)
7. [Methods and Interfaces](#7-methods-and-interfaces) - **HIGH**
   - 7.1 [Choose Pointer vs Value Receivers Deliberately](#71-choose-pointer-vs-value-receivers-deliberately)
   - 7.2 [Keep Interfaces Small and Focused](#72-keep-interfaces-small-and-focused)
   - 7.3 [Use Embedding for Composition](#73-use-embedding-for-composition)
8. [Concurrency](#8-concurrency) - **HIGH**
   - 8.1 [Share Memory by Communicating](#81-share-memory-by-communicating)
   - 8.2 [Close Channels from Senders and Range Receivers](#82-close-channels-from-senders-and-range-receivers)
   - 8.3 [Use select for Timeouts and Cancellation](#83-use-select-for-timeouts-and-cancellation)
9. [Errors](#9-errors) - **HIGH**
   - 9.1 [Treat Errors as Values](#91-treat-errors-as-values)
   - 9.2 [Wrap Errors with Context](#92-wrap-errors-with-context)
   - 9.3 [Use panic and recover Only for Programmer Errors](#93-use-panic-and-recover-only-for-programmer-errors)

---

## 1. Formatting and Commentary

**Impact: HIGH**

Consistent formatting and clear comments improve readability and tooling effectiveness.

### 1.1 Use gofmt for Formatting

**Impact: HIGH (ensures standard formatting and tooling compatibility)**

Let gofmt handle spacing, alignment, and semicolons. It produces the canonical style that every Go tool expects.

**Incorrect (manual alignment and inconsistent spacing):**

```go
if x>0{
    fmt.Println( "ok" )
}
```

**Correct (gofmt style):**

```go
if x > 0 {
	fmt.Println("ok")
}
```

### 1.2 Write Doc Comments as Full Sentences

**Impact: MEDIUM (improves readability and godoc output)**

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

---

## 2. Names and Packages

**Impact: HIGH**

Idiomatic names and package boundaries reduce friction and avoid stutter.

### 2.1 Use Short, Idiomatic Identifier Names

**Impact: HIGH (reduces noise and matches Go conventions)**

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

### 2.2 Keep Package Names Simple and Avoid Get

**Impact: HIGH (prevents stutter and improves API ergonomics)**

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

### 2.3 Use the Blank Identifier to Ignore Values

**Impact: MEDIUM (avoids unused variable errors while keeping intent clear)**

Use `_` to ignore values you do not need. This keeps code explicit and avoids unused variable errors.

**Incorrect (unused variable):**

```go
v, err := strconv.Atoi(s)
if err != nil {
	return err
}
// v is unused
```

**Correct (ignore with _):**

```go
_, err := strconv.Atoi(s)
if err != nil {
	return err
}
```

### 2.4 Use Blank Imports for Side Effects Only

**Impact: MEDIUM (keeps imports honest and explicit)**

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

---

## 3. Control Structures

**Impact: MEDIUM-HIGH**

Go's control flow favors clarity with short statements, range, and switch.

### 3.1 Use Short Statements in Control Flow

**Impact: MEDIUM-HIGH (keeps scopes tight and error handling local)**

Use short declarations in `if`, `for`, and `switch` to keep variables scoped to the control block.

**Incorrect (wider scope than needed):**

```go
f, err := os.Open(path)
if err != nil {
	return err
}
defer f.Close()
```

**Correct (scoped to the if block):**

```go
if f, err := os.Open(path); err != nil {
	return err
} else {
	defer f.Close()
}
```

### 3.2 Prefer range for Iteration

**Impact: MEDIUM (clearer loops and fewer indexing bugs)**

Use `for ... range` to iterate over slices, arrays, maps, and strings when you do not need the index.

**Incorrect (index when not needed):**

```go
for i := 0; i < len(names); i++ {
	fmt.Println(names[i])
}
```

**Correct (range):**

```go
for _, name := range names {
	fmt.Println(name)
}
```

Note: map iteration order is not deterministic.

### 3.3 Use switch and Type Switch for Clarity

**Impact: MEDIUM (reduces nested if/else and clarifies intent)**

Prefer `switch` over long if/else chains. Use type switches when branching on interface types.

**Incorrect (nested if/else):**

```go
if status == 400 {
	msg = "bad request"
} else if status == 404 {
	msg = "not found"
} else {
	msg = "unknown"
}
```

**Correct (switch):**

```go
switch status {
case 400:
	msg = "bad request"
case 404:
	msg = "not found"
default:
	msg = "unknown"
}
```

Type switch example:

```go
switch v := anyValue.(type) {
case string:
	fmt.Println("string", v)
case int:
	fmt.Println("int", v)
default:
	fmt.Printf("other %T\n", v)
}
```

---

## 4. Functions and Defer

**Impact: MEDIUM-HIGH**

Return values and defer patterns drive readable, robust APIs.

### 4.1 Return Multiple Values with error Last

**Impact: HIGH (standard Go error handling)**

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

### 4.2 Use Named Result Parameters Sparingly

**Impact: MEDIUM (improves clarity for simple functions)**

Named results can clarify intent for short functions, but avoid them in long or complex functions where they obscure control flow.

**Incorrect (named results hide return values):**

```go
func parsePort(s string) (port int, err error) {
	port, err = strconv.Atoi(s)
	if err != nil {
		return
	}
	if port <= 0 {
		err = errors.New("invalid port")
		return
	}
	return
}
```

**Correct (explicit returns):**

```go
func parsePort(s string) (int, error) {
	port, err := strconv.Atoi(s)
	if err != nil {
		return 0, err
	}
	if port <= 0 {
		return 0, errors.New("invalid port")
	}
	return port, nil
}
```

### 4.3 Use defer for Cleanup

**Impact: HIGH (ensures cleanup on all return paths)**

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

---

## 5. Data and Allocation

**Impact: HIGH**

Understanding slices, maps, and allocation avoids bugs and inefficiency.

### 5.1 Use make for Slices, Maps, and Channels

**Impact: HIGH (prevents nil map/slice panics)**

Use `make` to initialize slices, maps, and channels. `new` allocates zero values and is rarely needed for these types.

**Incorrect (nil map):**

```go
m := new(map[string]int)
(*m)["a"] = 1 // panic: assignment to entry in nil map
```

**Correct (make):**

```go
m := make(map[string]int)
m["a"] = 1
```

### 5.2 Prefer Composite Literals for Clarity

**Impact: MEDIUM (makes initialization explicit and stable)**

Use composite literals to initialize structs, arrays, and maps. Use keyed fields for long or exported structs to avoid order bugs.

**Incorrect (positional fields are brittle):**

```go
type Server struct {
	Host string
	Port int
}

s := Server{"localhost", 8080}
```

**Correct (keyed literal):**

```go
s := Server{
	Host: "localhost",
	Port: 8080,
}
```

### 5.3 Understand Slice Sharing, append, and copy

**Impact: HIGH (avoids unexpected mutations and memory retention)**

Slices share underlying arrays. Use `append` to grow and `copy` to make independent data.

**Incorrect (shared backing array mutates original):**

```go
orig := []int{1, 2, 3, 4}
sub := orig[:2]
sub[0] = 99
// orig is now [99 2 3 4]
```

**Correct (copy to isolate):**

```go
orig := []int{1, 2, 3, 4}
sub := make([]int, 2)
copy(sub, orig[:2])
sub[0] = 99
// orig remains [1 2 3 4]
```

### 5.4 Use Map Idioms with comma-ok

**Impact: HIGH (avoids nil map panics and missing key bugs)**

Maps return the zero value for missing keys. Use the comma-ok idiom when presence matters.

**Incorrect (can't distinguish missing key):**

```go
count := counts[name]
if count == 0 {
	// missing or explicitly zero?
}
```

**Correct (comma-ok):**

```go
count, ok := counts[name]
if !ok {
	// missing key
}
```

Remember to `make` maps before writing to them.

---

## 6. Initialization

**Impact: MEDIUM**

Use constants, variables, and init deliberately to keep behavior predictable.

### 6.1 Use const and iota for Enumerations

**Impact: MEDIUM (improves clarity and type safety)**

Use `const` with `iota` to define related values, and type them when appropriate.

**Incorrect (magic numbers):**

```go
const (
	statusNew = 1
	statusDone = 2
)
```

**Correct (typed iota):**

```go
type Status int

const (
	StatusNew Status = iota
	StatusDone
)
```

### 6.2 Keep init Small and Deterministic

**Impact: MEDIUM (avoids hidden side effects and ordering issues)**

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

---

## 7. Methods and Interfaces

**Impact: HIGH**

Receiver choice and small interfaces create flexible designs.

### 7.1 Choose Pointer vs Value Receivers Deliberately

**Impact: HIGH (avoids unintended copies and enables mutation)**

Use pointer receivers when methods mutate state or when the type is large. Use value receivers for small, immutable types.

**Incorrect (value receiver mutates a copy):**

```go
type Counter struct { n int }

func (c Counter) Inc() { c.n++ }
```

**Correct (pointer receiver):**

```go
func (c *Counter) Inc() { c.n++ }
```

Keep receiver choice consistent across methods on the same type.

### 7.2 Keep Interfaces Small and Focused

**Impact: HIGH (increases flexibility and reuse)**

Prefer small interfaces that describe a single behavior. Accept interfaces, return concrete types.

**Incorrect (large interface):**

```go
type Store interface {
	Get(id string) (Item, error)
	Put(item Item) error
	Delete(id string) error
	List() ([]Item, error)
}
```

**Correct (small interfaces):**

```go
type Getter interface {
	Get(id string) (Item, error)
}

type Putter interface {
	Put(item Item) error
}
```

### 7.3 Use Embedding for Composition

**Impact: MEDIUM-HIGH (promotes reuse without inheritance)**

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

---

## 8. Concurrency

**Impact: HIGH**

Channels and goroutines are powerful when used with clear ownership rules.

### 8.1 Share Memory by Communicating

**Impact: HIGH (avoids data races and simplifies synchronization)**

Prefer channels and message passing over shared mutable state.

**Incorrect (shared mutable state without sync):**

```go
var count int

func inc() {
	count++
}
```

**Correct (channel-based update):**

```go
func counter(ch <-chan struct{}, done chan<- int) {
	count := 0
	for range ch {
		count++
	}
	done <- count
}
```

### 8.2 Close Channels from Senders and Range Receivers

**Impact: HIGH (prevents deadlocks and panics)**

Only the sender should close a channel. Receivers should range until the channel is closed.

**Incorrect (receiver closes):**

```go
func worker(ch chan int) {
	for v := range ch {
		if v == 0 {
			close(ch) // unsafe: receiver closing
		}
	}
}
```

**Correct (sender closes):**

```go
func producer(ch chan<- int) {
	defer close(ch)
	for i := 0; i < 3; i++ {
		ch <- i
	}
}

func consumer(ch <-chan int) {
	for v := range ch {
		fmt.Println(v)
	}
}
```

### 8.3 Use select for Timeouts and Cancellation

**Impact: HIGH (prevents goroutine leaks and unbounded waits)**

Use `select` with `time.After` or `context` to avoid blocking forever on channels.

**Incorrect (can block forever):**

```go
v := <-ch
fmt.Println(v)
```

**Correct (timeout with select):**

```go
select {
case v := <-ch:
	fmt.Println(v)
case <-time.After(500 * time.Millisecond):
	return errors.New("timeout")
}
```

---

## 9. Errors

**Impact: HIGH**

Errors are values; wrap and propagate them with context.

### 9.1 Treat Errors as Values

**Impact: HIGH (enables explicit and consistent error handling)**

Errors are ordinary values. Return them and handle them explicitly.

**Incorrect (silent failure):**

```go
_ = doWork()
```

**Correct (handle the error):**

```go
if err := doWork(); err != nil {
	return err
}
```

### 9.2 Wrap Errors with Context

**Impact: HIGH (improves debuggability while preserving causes)**

Add context when returning errors and preserve the original error for inspection.

**Incorrect (loses context):**

```go
if err := writeFile(path); err != nil {
	return err
}
```

**Correct (wrap with context):**

```go
if err := writeFile(path); err != nil {
	return fmt.Errorf("write %s: %w", path, err)
}
```

Use `errors.Is` or `errors.As` to check wrapped errors.

### 9.3 Use panic and recover Only for Programmer Errors

**Impact: HIGH (keeps normal errors explicit and controllable)**

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

---

## References

1. https://go.dev/doc/effective_go
