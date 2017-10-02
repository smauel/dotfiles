# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/927019/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

PATH="${HOME}/.npm-packages/bin:$PATH"
eval $(thefuck --alias)

autoload -U promptinit; promptinit
prompt pure

# aliases
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias x='exit'
alias rm='rm -i'

alias dcua='docker-compose up -d api'
alias dcla='docker-compose logs -f api'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drm='docker rm -f $(docker ps -aq)'

export PATH="$HOME/.yarn/bin:$PATH"
