# dotfiles

my configs for setting up a new mac. configs live in this repo and get symlinked into place — edit here, commit, and every machine stays in sync.

## new mac setup

1. install [homebrew](https://brew.sh):
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```
2. clone this repo:
   ```sh
   git clone https://github.com/abena07/dotfiles.git ~/dotfiles
   ```
3. run the install script:
   ```sh
   cd ~/dotfiles
   ./install.sh
   ```

the script installs everything in the `Brewfile` first, then symlinks the configs.

## brewfile

apps, fonts and vs code extensions all live in the `Brewfile`. that's ghostty, brave, raycast, obsidian, spotify, discord, vs code, dm mono, and my vs code extensions (prettier, material icons, github theme, code runner). to add something, put a line in there and run `brew bundle` again.

## what's included

| folder | config | target location |
|--------|--------|-----------------|
| `zsh/` | `.zshrc` — shell aliases and color settings | `~/.zshrc` |
| `ghostty/` | `config` — github dark theme, dm mono font, 16-color palette | `~/.config/ghostty/config` |
| `vscode/` | `settings.json` — prettier, material icons, github dark theme | `~/Library/Application Support/Code/User/settings.json` |

## how it works

the install script symlinks each config to where the tool expects it. existing files get backed up to `*.backup` before being replaced.

```
~/dotfiles/ghostty/config       →  ~/.config/ghostty/config
~/dotfiles/zsh/.zshrc           →  ~/.zshrc
~/dotfiles/vscode/settings.json →  ~/Library/Application Support/Code/User/settings.json
```

edit files in this repo, commit, and the symlinks pick up changes automatically.

## adding a new config

1. create a folder: `mkdir toolname`
2. add the config file inside it
3. add a `link_file` line to `install.sh`:
   ```sh
   link_file "$DOTFILES/toolname/config" "$HOME/.config/toolname/config"
   ```
4. commit and push

## file structure

```
dotfiles/
├── Brewfile                # apps, fonts, vs code extensions
├── install.sh              # runs brew bundle, then symlinks everything
├── readme.md
├── ghostty/
│   └── config              # ghostty terminal config
├── vscode/
│   └── settings.json       # vs code settings
└── zsh/
    └── .zshrc              # shell config
```
