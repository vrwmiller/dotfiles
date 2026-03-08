# dotfiles

Personal shell configuration and dotfiles for macOS and UNIX-like systems.

## Contents

| File | Description |
|------|-------------|
| `aliases.sh` | Shell aliases shared across bash/sh/zsh |
| `.bash_profile` | Bash login shell config (sources `aliases.sh`) |
| `.profile` | POSIX sh login shell config (sources `aliases.sh`) |
| `.zshrc` | Zsh config (sources `aliases.sh`) |
| `.vimrc` | Vim configuration |
| `.exrc` | ex/vi configuration |

## Installation

Uses `make` to install files into `$HOME` with correct ownership and permissions.

```bash
# Install everything (all shells + vim + ex)
make all

# Install for a specific shell only
make bash   # installs .bash_profile + aliases.sh
make zsh    # installs .zshrc
make sh     # installs .profile + aliases.sh

# Install individual components
make aliases  # installs aliases.sh only
make vim      # installs .vimrc
make ex       # installs .exrc
```

## License

MIT — see [LICENSE](LICENSE).
