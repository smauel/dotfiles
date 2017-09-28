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
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

export PATH="$HOME/.yarn/bin:$PATH"
