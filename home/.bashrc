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
alias g='git'
alias gs='git st'
alias gd='git df'
alias gds='git dfs'
alias gl='git lg'
alias gap='git ap'
alias ll='ls -la'
alias ..='cd ..'
alias ...='cd ../..'

source "${HOME}/.local/bin/taskr_completion"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--preview-window hidden'
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

PS1='[\u@\h \W]\$ '
