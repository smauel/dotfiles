#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias x='exit'
alias cc='clear'
alias gs='git status'
alias gd='git diff'
alias gap='git add -p'
alias ll='ls -la'

PS1='[\u@\h \W]\$ '
