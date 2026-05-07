# Repository Templates

## Contributing Guidelines

Before creating issues or pull requests, check for repository instructions in
the common locations:

- `CONTRIBUTING.md`
- `.github/CONTRIBUTING.md`
- `docs/CONTRIBUTING.md`

Follow repository-specific requirements over the generic skill defaults.

## Issue Templates

When creating an issue, inspect `.github/ISSUE_TEMPLATE/` first. If templates
exist, use them to guide the issue shape instead of inventing a separate
structure.

Recommended flow:

1. List available templates with `gh issue create --list` when supported.
2. Read the matching template file under `.github/ISSUE_TEMPLATE/`.
3. Preserve the template's required headings, prompts, and checklist items.
4. Fill unknown or irrelevant fields with `N/A` only when the template allows
   it or the field is clearly optional.
5. Keep labels and issue type aligned with the selected template metadata.

Issue template locations to check:

- `.github/ISSUE_TEMPLATE/*.md`
- `.github/ISSUE_TEMPLATE/*.yml`
- `.github/ISSUE_TEMPLATE/*.yaml`
- `.github/ISSUE_TEMPLATE/config.yml`

## Pull Request Templates

When creating a pull request, check for templates before drafting the body.

Pull request template locations to check:

- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE/*.md`
- `PULL_REQUEST_TEMPLATE.md`
- `docs/PULL_REQUEST_TEMPLATE.md`

Preserve the repository template's section headers and required checklist
items. Add concise content under each section, using `N/A` only for fields that
are genuinely not applicable.
