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

zstyle :compinstall filename '/home/sam/.config/zsh/.zshrc'

autoload -Uz compinit
compinit

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats " %F{red}(%b)%f"

precmd () {
    vcs_info
}

setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f${vcs_info_msg_0_}%F{green} >%f '

export EDITOR='nvim'
export PAGER='less'
export BROWSER='chromium'
export PATH=$PATH:$HOME/.local/bin

alias x='exit'
alias cc='clear'
alias ll='ls -la'
alias rm='rm -i'
alias vim='nvim'

alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gap='git add -p'

source <(fzf --zsh)
