# ----- Colors -----
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# ls colors
alias ls='ls -G'

# grep colors
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias activate='source venv/bin/activate'
alias cluade='claude'

# secrets (api keys, tokens) go in ~/.zshrc.local, which never goes in the repo
[ -f ~/.zshrc.local ] && source ~/.zshrc.local
