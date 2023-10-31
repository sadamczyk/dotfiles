# Personal dotfiles

## Installation

- Install [brew](https://brew.sh/)
- Install [chezmoi](https://www.chezmoi.io/)
- Initialize personal dotfiles

```sh
sudo -v \
  && NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" \
  && brew install chezmoi \
  && chezmoi init --apply sadamczyk
```
