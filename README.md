# Dotfiles

Personal configuration files for development environment.

## Contents

- **doom/**: Doom Emacs configuration
- **bash/**: Bash configuration files
- **install.sh**: Installation script to set up symlinks

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Manual Installation

If you prefer to set up symlinks manually:

```bash
# Doom Emacs config
ln -sf ~/dotfiles/doom ~/.config/doom

# Bash configs
ln -sf ~/dotfiles/bash/.bashrc ~/.bashrc
ln -sf ~/dotfiles/bash/.bash_profile ~/.bash_profile
```

## Doom Emacs Setup

After symlinking the config:

```bash
~/.emacs.d/bin/doom sync
```
