#!/bin/bash

set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to backup and symlink
backup_and_link() {
    local source="$1"
    local target="$2"

    # Create target directory if needed
    local target_dir="$(dirname "$target")"
    mkdir -p "$target_dir"

    # Backup if exists and is not already a symlink to our dotfiles
    if [ -e "$target" ] && [ "$(readlink "$target")" != "$source" ]; then
        echo "Backing up existing $target to $BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/"
    elif [ -L "$target" ]; then
        rm "$target"
    fi

    # Create symlink
    echo "Linking $source -> $target"
    ln -sf "$source" "$target"
}

# Doom Emacs config
echo "Setting up Doom Emacs configuration..."
backup_and_link "$DOTFILES_DIR/doom" "$HOME/.config/doom"

# Bash configs
echo "Setting up Bash configuration..."
backup_and_link "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
backup_and_link "$DOTFILES_DIR/bash/.bash_profile" "$HOME/.bash_profile"

echo ""
echo "Dotfiles installation complete!"
echo ""
echo "Next steps:"
echo "  1. Restart your shell or run: source ~/.bashrc"
echo "  2. If Doom Emacs config changed, run: ~/.emacs.d/bin/doom sync"
echo ""
if [ -d "$BACKUP_DIR" ] && [ "$(ls -A $BACKUP_DIR)" ]; then
    echo "Your old dotfiles were backed up to: $BACKUP_DIR"
fi
