#!/bin/bash

# dotfiles installer
# installs everything in the Brewfile, symlinks configs into place, then applies macos settings

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info() { printf "\033[0;34m[info]\033[0m %s\n" "$1"; }
ok()   { printf "\033[0;32m[ok]\033[0m   %s\n" "$1"; }
warn() { printf "\033[0;33m[warn]\033[0m %s\n" "$1"; }

link_file() {
    local src="$1" dst="$2"

    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -f "$dst" ]; then
        warn "backing up existing $dst to ${dst}.backup"
        mv "$dst" "${dst}.backup"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -sf "$src" "$dst"
    ok "linked $dst -> $src"
}

# --- homebrew ---
# apple silicon puts brew in /opt/homebrew, which might not be on PATH yet
if ! command -v brew >/dev/null 2>&1 && [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if ! command -v brew >/dev/null 2>&1; then
    warn "homebrew isn't installed. install it with:"
    warn '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    warn "then run ./install.sh again"
    exit 1
fi

info "installing stuff from the Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

# --- zsh ---
info "setting up zsh"
link_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# --- ghostty ---
info "setting up ghostty"
link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# --- git ---
info "setting up git"
link_file "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"

# --- vs code ---
info "setting up vs code"
link_file "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

# --- ssh ---
info "setting up ssh"
if [ ! -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-keygen -t ed25519 -C "62352130+abena07@users.noreply.github.com" -f "$HOME/.ssh/id_ed25519"
    pbcopy < "$HOME/.ssh/id_ed25519.pub"
    ok "new ssh key made and the public key is copied"
    warn "paste it into github > settings > ssh and gpg keys > new ssh key"
else
    ok "ssh key already exists, skipping"
fi

# --- dotfiles remote ---
git -C "$DOTFILES" remote set-url origin git@github.com:abena07/dotfiles.git
ok "dotfiles remote is now git@github.com:abena07/dotfiles.git"

# --- macos settings ---
info "applying macos settings"
"$DOTFILES/macos.sh"

echo ""
ok "done! restart your shell or run: source ~/.zshrc"
