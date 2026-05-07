# Examples

## Conventional Commits

Use small, atomic commits with a lowercase conventional title.

```text
feat(auth): add oauth callback handling
fix(api): handle empty search queries
docs(readme): update setup instructions
test(payments): cover failed webhook retries
chore(deps): update lockfile
```

## Issue References

Use auto-closing keywords only when the work should close the issue after
merge.

```text
Closes #123
Fixes #456
Resolves #789
```

For related work that should not close automatically, use a non-closing
reference.

```text
Related to #123
Follow-up to #456
```

## Branch Names

Prefer short branch names that include the issue number when available.

```text
fix/123-auth-redirect
feat/456-export-csv
docs/789-api-examples
refactor/321-query-builder
```
