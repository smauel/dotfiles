# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f $HOME/.gitauthor ] && source $HOME/.gitauthor
[ -f $HOME/.zsh-path ] && source $HOME/.zsh-path
[ -f $HOME/.zsh-prompt ] && source $HOME/.zsh-prompt
[ -f $HOME/.zsh-env ] && source $HOME/.zsh-env
# Important to load this last as it contains the brew overrides
[ -f $HOME/.zsh-aliases ] && source $HOME/.zsh-aliases

# load nodenv for handling versions of node
eval "$(nodenv init -)"
