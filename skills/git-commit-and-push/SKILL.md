---
name: git-commit-and-push
description: Creates conventional git commits using standard git commands and pushes to the remote repository. This skill should be used when the user asks to "commit and push", "push my changes", or wants to commit and immediately push to remote.
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
6. Push with `git push`; if no upstream is configured, use `git push -u origin <branch>`
7. Verify the result with `git status --short`
