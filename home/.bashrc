#
# ~/.bashrc
#

export PATH="${HOME}/.local/bin:${PATH}"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias x='exit'
alias cc='clear'
alias gs='git status'
alias gd='git diff'
alias gds='git diff --staged'
alias gap='git add -p'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'

source "${HOME}/.local/bin/taskr_completion"

PS1='[\u@\h \W]\$ '
