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

the script installs everything in the `Brewfile` first, then symlinks the configs. at the end it makes an ssh key if there isn't one, copies the public key, and switches this repo's remote to ssh. paste the key into github > settings > ssh and gpg keys before you push anything.

last thing it runs is `macos.sh`, which sends screenshots to the clipboard and keeps the desktop empty (no icons, no external disks or dmgs). you can run it on its own too.

## brewfile

apps, fonts and vs code extensions all live in the `Brewfile`. that's ghostty, brave, raycast, obsidian, spotify, discord, vs code, dm mono, and my vs code extensions (prettier, material icons, github theme, code runner). to add something, put a line in there and run `brew bundle` again.

## what's included

| folder | config | target location |
|--------|--------|-----------------|
| `zsh/` | `.zshrc` — shell aliases and color settings | `~/.zshrc` |
| `git/` | `.gitconfig` — name, noreply email, main as default branch | `~/.gitconfig` |
| `ghostty/` | `config` — github dark theme, dm mono font, 16-color palette | `~/.config/ghostty/config` |
| `vscode/` | `settings.json` — prettier, material icons, github dark theme | `~/Library/Application Support/Code/User/settings.json` |

## how it works

the install script symlinks each config to where the tool expects it. existing files get backed up to `*.backup` before being replaced.

```
~/dotfiles/ghostty/config       →  ~/.config/ghostty/config
~/dotfiles/zsh/.zshrc           →  ~/.zshrc
~/dotfiles/git/.gitconfig       →  ~/.gitconfig
~/dotfiles/vscode/settings.json →  ~/Library/Application Support/Code/User/settings.json
```

edit files in this repo, commit, and the symlinks pick up changes automatically.

## secrets

this repo is public, so no keys, tokens or passwords in here. put them in `~/.zshrc.local` instead, `.zshrc` loads it if it exists. it's in `.gitignore` too, just in case.

```sh
export SOME_API_KEY="..."
```

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
├── install.sh              # brew bundle, symlinks, ssh key
├── macos.sh                # macos settings
├── readme.md
├── ghostty/
│   └── config              # ghostty terminal config
├── git/
│   └── .gitconfig          # git name, email, default branch
├── vscode/
│   └── settings.json       # vs code settings
└── zsh/
    └── .zshrc              # shell config
```
