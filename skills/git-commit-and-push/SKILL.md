---
name: git-commit-and-push
description: Creates conventional git commits using standard git commands and pushes to the remote repository. This skill should be used when the user asks to "commit and push", "push my changes", or wants to commit and immediately push to remote.
user-invocable: true
model: haiku
allowed-tools: ["Bash(git:*)"]
---

Use standard `git` commands only.

1. Inspect the worktree with `git status --short`
2. Check the scale of the change with `git diff --stat` and `git diff --cached --stat` — do not read the full diff yet
3. Branch on scale:
   - **Small change** (roughly ≤5 files and ≤150 changed lines): run `git diff` / `git diff --cached` to read the full content, and write a specific commit message describing what actually changed
   - **Large change** (beyond that, or concentrated changes in generated/lock files): skip reading the full diff. Write an abstract commit message based only on the file paths from `git status --short` / `--stat`, summarizing the affected areas/modules without inventing implementation details you haven't read
4. Accuracy over specificity: never state a detail you didn't actually see in the diff
5. Stage intended changes with `git add` or `git add -A`, unless the user explicitly requested a staged-only commit
6. Create a Conventional Commits message from the actual changes
7. Commit with `git commit -m "<type>(<scope>): <summary>"` or a multi-line message when useful
8. Push with `git push`; if no upstream is configured, use `git push -u origin <branch>`
9. Verify the result with `git status --short`
