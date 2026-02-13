HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt autocd 
setopt extendedglob 
setopt nomatch
setopt extendedhistory
setopt sharehistory
setopt appendhistory
setopt incappendhistory
setopt histexpiredupsfirst
setopt histignoredups
setopt histignoredups
setopt histfindnodups
setopt histreduceblanks
setopt correct
setopt correctall
unsetopt beep notify
bindkey -e

autoload -Uz compinit
compinit

# prompt
eval "$(starship init zsh)"

export EDITOR='nvim'
export PAGER='less'
export BROWSER='chromium'
export PATH="$PATH:$HOME/.local/bin:$HOME/.cargo/bin"

alias x='exit'
alias cc='clear'
alias ll='ls -la'
alias rm='rm -i'
alias v='nvim'
alias vim='nvim'
alias vv='nvim $(fd --type f | fzf)'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'

alias k='kubectl'
alias tm='tmux-start'

source <(fzf --zsh)
eval "$(/usr/bin/mise activate zsh)"
