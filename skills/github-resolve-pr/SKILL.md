---
name: github-resolve-pr
allowed-tools: Task, Bash(gh:*), Bash(git:*)
description: Resolve GitHub pull request review feedback using GitHub CLI. Use when an agent needs to inspect the current branch PR, fetch PR comments and review comments, fix reviewer-requested changes, validate the fixes, and mark GitHub review threads resolved with gh.
argument-hint: [optional PR number, URL, branch, or review focus]
user-invocable: true
---

# Resolve GitHub PR Reviews

## Overview

Use this skill to resolve review feedback on the pull request associated with the current branch. It gathers PR conversation comments and unresolved review threads, guides code fixes and validation, then marks verified review threads resolved through GitHub GraphQL.

## Workflow

1. Confirm repository state with `git status`, `git branch --show-current`, and `gh auth status`.
2. Identify the current branch PR and general PR comments:

```bash
gh pr view --json number,url,title,headRefName,baseRefName,comments,reviews,latestReviews,files,reviewDecision,statusCheckRollup
```

3. Fetch unresolved review threads with the GraphQL commands in `references/gh-commands.md`.
4. Group feedback by file and root cause. Treat unresolved review threads as actionable; treat general PR comments as context or follow-up requests.
5. Inspect referenced code, implement the smallest coherent fixes, and preserve unrelated local changes.
6. Run relevant project validation before resolving any thread.
7. Resolve only verified thread IDs with the `resolveReviewThread` command in `references/gh-commands.md`.


## Rules

- Default to the current branch PR. If `gh pr view` cannot identify one, ask for a PR number, URL, or branch.
- Do not mark a review thread resolved until the requested change is present and validation has run.
- If a thread is outdated, verify the current code before deciding it is resolved.
- Keep a list of thread IDs that were fixed, already addressed, ambiguous, or left unresolved.
- Push or commit changes only when the user's request or the repository workflow calls for it.

## References

- Read `references/workflow.md` for the full review-resolution process.
- Read `references/gh-commands.md` when direct `gh` or GraphQL command details are needed.
