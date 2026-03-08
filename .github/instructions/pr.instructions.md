---
applyTo: "**"
---

# Pull Request Agent Instructions

## Branch rules
- Never commit directly to `master` — all changes go on a feature branch.
- Branch names must be descriptive: `feat/<topic>`, `fix/<topic>`, `chore/<topic>`.
- Open a PR to merge into `master`.

## PR title format
Use the same convention as commit messages:
```
feat: short description of what was added
fix: short description of what was corrected
chore: tooling, CI, or non-functional changes
```

## PR description structure

### For simple changes (single-file edits, small fixes)
A short paragraph is sufficient:
- What changed and why
- Any issue it closes (`Closes #N`)

### For larger changes, use this template:
```
## Summary
One or two sentences describing the overall change.

## Changes
- Bullet list of specific files/components modified and what changed in each

## Motivation
Why this change is needed — reference the open issue if one exists (`Closes #N` or `Related to #N`).

## Breaking changes
- List any changes that would affect existing installs (e.g. renamed files, changed install targets)
- If none: "None"
```

## Referencing issues
- Always link related issues: `Closes #N` (auto-closes on merge) or `Related to #N`.
- If the PR partially addresses an issue, say so explicitly.

## Checklist before opening
- [ ] Branch is not `master`
- [ ] `make all` installs cleanly on a fresh system
- [ ] No credentials, tokens, or sensitive values added to any tracked file
- [ ] Commit(s) are GPG-signed (`git log --show-signature -1`)

## Using the gh CLI
Always use `--body-file` when creating or editing PRs and issues with multi-line descriptions. Write the body file using an editor tool — never shell heredocs or `echo` redirection.

```bash
gh pr create --title "feat: description" --body-file /tmp/pr-body.txt --base master
gh pr edit 42 --body-file /tmp/pr-body.txt
gh issue create --title "title" --body-file /tmp/issue-body.txt
```
