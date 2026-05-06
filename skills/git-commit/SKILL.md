---
name: git-commit
description: Creates a conventional git commit using standard git commands. This skill should be used when the user requests "commit", "git commit", "create commit", or wants to commit staged and unstaged changes following the conventional commits format.
user-invocable: true
model: haiku
allowed-tools: ["Bash(git:*)"]
---

Use standard `git` commands only.

1. Inspect the worktree with `git status --short`
2. Review changes with `git diff` and `git diff --cached`
3. Stage intended changes with `git add` or `git add -A`, unless the user explicitly requested a staged-only commit
4. Create a Conventional Commits message from the actual changes
5. Commit with `git commit -m "<type>(<scope>): <summary>"` or a multi-line message when useful
6. Verify the result with `git status --short`
