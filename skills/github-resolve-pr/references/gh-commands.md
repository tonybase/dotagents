# GitHub CLI Commands

Use these commands from the repository worktree that contains the PR branch.

## Current PR

```bash
gh pr view --json number,url,title,headRefName,baseRefName,reviewDecision,statusCheckRollup
```

Without an argument, `gh pr view` resolves the pull request associated with the current branch. If that fails, accept an explicit PR number, URL, or branch from the user.

## PR Comments and Review Fields

```bash
gh pr view --json comments,reviews,latestReviews,files
```

The `comments` field contains general PR conversation comments. Review-thread line comments require GraphQL `reviewThreads`.

## Shell Variables

```bash
PR_NUMBER=$(gh pr view --json number --jq '.number')
OWNER=$(gh repo view --json owner --jq '.owner.login')
REPO=$(gh repo view --json name --jq '.name')
```

## Review Threads Query

```bash
gh api graphql --paginate \
  -F owner="$OWNER" \
  -F name="$REPO" \
  -F number="$PR_NUMBER" \
  -f query='
query($owner: String!, $name: String!, $number: Int!, $endCursor: String) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $number) {
      reviewThreads(first: 100, after: $endCursor) {
        nodes {
          id
          isResolved
          isOutdated
          path
          line
          originalLine
          comments(first: 100) {
            nodes {
              url
              author { login }
              body
              diffHunk
              createdAt
            }
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
  }
}'
```

Filter to unresolved threads with `--jq` when a compact view is enough:

```bash
gh api graphql --paginate \
  -F owner="$OWNER" \
  -F name="$REPO" \
  -F number="$PR_NUMBER" \
  -f query='
query($owner: String!, $name: String!, $number: Int!, $endCursor: String) {
  repository(owner: $owner, name: $name) {
    pullRequest(number: $number) {
      reviewThreads(first: 100, after: $endCursor) {
        nodes {
          id
          isResolved
          isOutdated
          path
          line
          originalLine
          comments(first: 100) {
            nodes {
              url
              author { login }
              body
              diffHunk
              createdAt
            }
          }
        }
        pageInfo {
          hasNextPage
          endCursor
        }
      }
    }
  }
}' --jq '.data.repository.pullRequest.reviewThreads.nodes[] | select(.isResolved == false)'
```

## Resolve Thread Mutation

```bash
THREAD_ID='THREAD_ID'

gh api graphql -F threadId="$THREAD_ID" -f query='
mutation($threadId: ID!) {
  resolveReviewThread(input: {threadId: $threadId}) {
    thread {
      id
      isResolved
    }
  }
}'
```

## Failed Checks and Actions Jobs

Inspect PR checks first:

```bash
gh pr view --json statusCheckRollup --jq '.statusCheckRollup'
```

For GitHub Actions workflow runs, list jobs from the run ID:

```bash
RUN_ID='RUN_ID'

gh api "repos/$OWNER/$REPO/actions/runs/$RUN_ID/jobs" --paginate \
  --jq '.jobs[] | {id, name, status, conclusion, html_url}'
```

Fetch step-level details from the job ID:

```bash
JOB_ID='JOB_ID'

gh api "repos/$OWNER/$REPO/actions/jobs/$JOB_ID" \
  --jq '{id, run_id, conclusion, steps: [.steps[] | {name, conclusion}]}'
```

Do not call `repos/$OWNER/$REPO/actions/runs/$RUN_ID/jobs/$JOB_ID`; GitHub returns 404 for that URL shape. Use `actions/runs/$RUN_ID/jobs` to list jobs and `actions/jobs/$JOB_ID` to inspect one job.
