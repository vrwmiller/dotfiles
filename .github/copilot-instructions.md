# Copilot Instructions

## Tooling Preferences
- Use the `gh` CLI for all GitHub-related operations: viewing issues (`gh issue view`), creating/reviewing PRs, managing releases, querying the API, etc.
- `gh` is sufficient for all common GitHub tasks — do not use other tools for operations that `gh` can handle.

## Purpose
This repository contains personal dotfiles and shell configuration. It uses a Makefile to install config files into `$HOME` with correct ownership and permissions. Keep changes simple, portable, and shell-agnostic where possible.

## Security
- Never hardcode passwords, API keys, tokens, or other credentials in aliases, shell configs, or any tracked file.
- Use environment variables or external secret managers for sensitive values.

## Branch Strategy
- All changes must be made on a feature branch, never committed directly to `master`.
- Open a pull request to merge changes into `master`.
- Branch names should be descriptive and reflect the work being done (e.g., `feat/add-git-aliases`, `fix/zsh-path`).

## GPG Commit Signing
- All contributors must make every effort to sign their git commits using a GPG key.
- Signed commits help verify authorship and improve repository security.
- Unsigned commits may be flagged during code review and should be avoided unless absolutely necessary.

### Setup Instructions
1. Generate a GPG key if you do not have one:
  ```bash
  gpg --full-generate-key
  ```
2. List your GPG keys:
  ```bash
  gpg --list-secret-keys --keyid-format LONG
  ```
3. Configure git to use your signing key:
  ```bash
  git config --global user.signingkey <YOUR_KEY_ID>
  git config --global commit.gpgsign true
  ```
4. Optionally, add your public key to your GitHub account for verified signatures.

### Testing GPG Signing
To verify that commit signing works:
1. Make a test commit with signing:
  ```bash
  echo "# GPG signing test" > gpg-sign-test.txt
  git add gpg-sign-test.txt
  git commit -S -m "test: verify GPG commit signing"
  ```
2. Check the commit signature:
  ```bash
  git log --show-signature -1
  ```
3. On GitHub, look for the "Verified" badge on your commit or PR.

## GitHub CLI Body Content
- When providing multi-line body content to any `gh` command (`gh issue create`, `gh pr create`, `gh pr edit`, etc.), always use the `--body-file` option.
- This prevents shell quoting errors and terminal corruption of the content.
- **Always write body files using editor tools (e.g. `create_file`), never via terminal heredocs.**
- Example workflow:
  1. Write the body to a file, e.g. `/tmp/pr-body.txt`.
  2. Run:
    ```bash
    gh pr create --title "feat: description" --body-file /tmp/pr-body.txt --base master
    gh pr edit 42 --body-file /tmp/pr-body.txt
    gh issue create --title "Bug: description" --body-file /tmp/issue-body.txt
    ```
  3. Delete the temp file after the gh command succeeds.
- Do not paste multi-line body content directly into the shell.
