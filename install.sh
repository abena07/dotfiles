#!/bin/bash

# dotfiles installer
# creates symlinks from this repo to where each tool expects its config

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

# --- zsh ---
info "setting up zsh"
link_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"

# --- ghostty ---
info "setting up ghostty"
link_file "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"

# --- vs code ---
info "setting up vs code"
link_file "$DOTFILES/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json"

# --- font ---
if ! fc-list 2>/dev/null | grep -qi "DM Mono" && ! system_profiler SPFontsDataType 2>/dev/null | grep -qi "DM Mono"; then
    warn "dm mono font not found — install it:"
    warn "  brew install --cask font-dm-mono"
else
    ok "dm mono font detected"
fi

echo ""
ok "done! restart your shell or run: source ~/.zshrc"
