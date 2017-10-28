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
alias p='./projects'
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias x='exit'
alias rm='rm -i'
alias vim='/Applications/MacVim.app/Contents/bin/vim'

alias dcua='docker-compose up -d api'
alias dcl='docker-compose logs -f'
alias dcla='docker-compose logs -f api'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias drm='docker rm -f $(docker ps -aq)'

export PATH="$HOME/.yarn/bin:$PATH"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
