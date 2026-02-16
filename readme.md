# dotfiles

my configs for setting up a new mac. configs live in this repo and get symlinked into place — edit here, commit, and every machine stays in sync.

## quick setup

```sh
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## what's included

| folder | config | target location |
|--------|--------|-----------------|
| `zsh/` | `.zshrc` — shell aliases and color settings | `~/.zshrc` |
| `ghostty/` | `config` — github dark theme, dm mono font, 16-color palette | `~/.config/ghostty/config` |
| `vscode/` | `settings.json` — prettier, material icons, github dark theme | `~/Library/Application Support/Code/User/settings.json` |

## how it works

the install script symlinks each config to where the tool expects it. existing files get backed up to `*.backup` before being replaced.

```
~/dotfiles/ghostty/config  →  ~/.config/ghostty/config
~/dotfiles/zsh/.zshrc      →  ~/.zshrc
~/dotfiles/vscode/settings →  ~/Library/Application Support/Code/User/settings.json
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

## font

ghostty and vs code both use [dm mono](https://fonts.google.com/specimen/DM+Mono). install it with:

```sh
brew install --cask font-dm-mono
```

## vs code extensions

```sh
code --install-extension esbenp.prettier-vscode
code --install-extension PKief.material-icon-theme
code --install-extension GitHub.github-vscode-theme
code --install-extension formulahendry.code-runner
```

## file structure

```
dotfiles/
├── install.sh              # symlinks everything into place
├── readme.md
├── ghostty/
│   └── config              # ghostty terminal config
├── vscode/
│   └── settings.json       # vs code settings
└── zsh/
    └── .zshrc              # shell config
```
