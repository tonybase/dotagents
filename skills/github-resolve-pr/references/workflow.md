# Resolve PR Review Workflow

Use this workflow to fix review feedback on the current branch PR and mark verified review threads as resolved.

## Preflight

1. Confirm repository state with `git status`, `git branch --show-current`, and `gh auth status`.
2. Identify the current branch PR with `gh pr view --json number,url,title,headRefName,baseRefName,reviewDecision`.
3. Inspect unpushed commits before editing. Preserve unrelated local changes and avoid rebasing or resetting unless the user asks.
4. If `gh pr view` cannot find a PR for the current branch, ask for a PR number, URL, or branch.

## Collect Feedback

Identify the PR and general PR comments:

```bash
gh pr view --json number,url,title,headRefName,baseRefName,comments,reviews,latestReviews,files,reviewDecision,statusCheckRollup
```

Then run the review-thread GraphQL query from `references/gh-commands.md`.

Use the output as the review source of truth:

- Treat general PR comments as context or requested follow-up.
- Treat unresolved review threads as actionable unless current code has already made the thread obsolete.
- Group comments by file and root cause before editing.
- Keep thread IDs for only the comments that are actually fixed and validated.

## Fix and Validate

1. Inspect each referenced file and nearby code before editing.
2. Make the smallest coherent change that resolves the reviewer concern.
3. Handle outdated review threads by verifying the current code. If the concern is already addressed, record the thread ID and do not make unnecessary edits.
4. Run targeted tests first, then the project’s relevant lint/build/test commands based on manifests and changed areas.
5. If CI checks are failing, inspect `statusCheckRollup` and GitHub Actions job steps with the commands in `references/gh-commands.md`.
6. If tests fail, fix the failure or clearly separate pre-existing failures from review-fix regressions.

## Push and Resolve

1. Commit or stage changes only according to the user’s request and repo conventions.
2. Push the review-fix branch when the user asked for a complete PR resolution workflow or when the local repo’s existing workflow expects pushed fixes.
3. Resolve only verified thread IDs with the `resolveReviewThread` GraphQL command from `references/gh-commands.md`.
4. Never mark a thread resolved before the relevant fix is present and validation has run.
5. Report fixed threads, unresolved or ambiguous feedback, validation commands, and any push/commit status.
