# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt sharehistory
setopt incappendhistory
setopt autocd
setopt extendedglob
setopt nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# path
NPM="${HOME}/.npm-packages/bin"
GO="${HOME}/go/bin"
YARN="$HOME/.yarn/bin"
PG="/usr/local/opt/postgresql@9.6/bin"
SBIN="/usr/local/sbin"
export PATH="${NPM}:${GO}:${YARN}:${PG}:${SBIN}:${PATH}"

# editor
if [[ "$OSTYPE" == "darwin"* ]]; then
  export EDITOR=$(which nvim)
  export VISUAL=$(which mvim)
else
  export EDITOR=$(which vim)
fi

# source git author details from file
[ -f $HOME/.gitauthor ] && source $HOME/.gitauthor

# fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # respect .gitignore
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--reverse"
fi

# kubernetes
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# aliases
[ -f ~/.aliases ] && source ~/.aliases

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
zplug "plugins/git", from:oh-my-zsh
zplug "ael-code/zsh-colored-man-pages"
zplug "peterhurford/git-it-on.zsh"
zplug "diazod/git-prune"
zplug "Dbz/kube-aliases"
zplug "greymd/docker-zsh-completion"
zplug "caarlos0/zsh-open-pr"
zplug "djui/alias-tips"
zplug load
