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

# path
NPM="${HOME}/.npm-packages/bin"
GO="${HOME}/go/bin"
YARN="$HOME/.yarn/bin"
PG="/usr/local/opt/postgresql@9.6/bin"
export PATH="${NPM}:${GO}:${YARN}:${PG}:${PATH}"

# prompt
autoload -U promptinit; promptinit
prompt pure
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
RPROMPT='$(kube_ps1)'

# editor
if [[ "$OSTYPE" == "darwin"* ]]; then
  export EDITOR=$(which vim)
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
  export FZF_DEFAULT_OPTS="--ansi --reverse --preview-window 'right:60%' --preview 'bat --color=always --style=header,grid {}'"
fi

# addons
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
[ -x "$(command -v nodenv)" ] && eval "$(nodenv init -)"

# functions
# Custom brew function to help version control brew.
# These overrides write to the corresponding .brews, .casks
# or .taps file when a new brew, cask or tap is installed.
# All other brew commands are passed through
function brew() {
  if [ $# -eq 0 ]; then
    /usr/local/bin/brew
  elif [[ "$1" == "install" ]]; then
    shift
    /usr/local/bin/brew install "$@"
    /usr/local/bin/brew list > $HOME/.brews
  elif [[ "$1" == uninstall ]]; then
    shift
    /usr/local/bin/brew uninstall "$@"
    /usr/local/bin/brew list > $HOME/.brews
  elif [[ "$1" == "cask" && "$2" == "install" ]]; then
    shift
    shift
    /usr/local/bin/brew cask install "$@"
    /usr/local/bin/brew cask list > $HOME/.casks
  elif [[ "$1" == "cask" && "$2" == "uninstall" ]]; then
    shift
    shift
    /usr/local/bin/brew cask uninstall ${formulae}
    /usr/local/bin/brew cask list > $HOME/.casks
  elif [[ "$1" == "tap" ]]; then
    shift
    for formulae in "${@}"; do
      /usr/local/bin/brew tap ${formulae}
      [ $? -eq 0 ] && echo ${formulae} >> ${HOME}/.taps
    done
  else
    /usr/local/bin/brew "$@"
  fi
}

# general aliases
alias dotfiles="cd ${HOME}/dotfiles"
alias scripts="cd ${HOME}/scripts"
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias x='exit'
alias rm='rm -i'
alias tmux='tmux -2'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias b64='function(){echo $1 | base64}'
alias ub64='function(){echo $1 | base64 -D}'

# git aliases
alias g='git'
alias gc='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias ga='git add'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull'
alias gpom='git push origin master'
alias gpot='git push origin --tags'

# docker aliases
alias d='docker'
alias dc='docker-compose'
alias dupapi='docker-compose up -d api'
alias dlogs='docker-compose logs -f'
alias dps='docker ps'
alias dpa='docker ps --all'
alias di='docker images'
alias drm='docker rm $(docker ps -aq)'
alias dri='docker rmi $(docker images -q)'
alias dstop='docker stop $(docker ps -aq)'
alias dprune='docker system prune && docker volume prune'

# aws aliases
alias mfa-start-session='function(){eval $(command mfa-start-session $@);}'
alias mfa-end-session='function(){eval $(command mfa-end-session); unset AWS_SESSION_TOKEN AWS_SECRET_ACCESS_KEY AWS_ACCESS_KEY_ID}'
alias assume-role='function(){eval $(command assume-role $@);}'

# kubectl aliases
alias k='kubectl'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgs='kubectl get service'
alias kgi='kubectl get ingress'
alias kgd='kubectl get deployment'
alias kpf='kubectl port-forward'
alias kns='kubens'
alias kctx='kubectx'

# suffix aliases
alias -s md='vim'
alias -s js='node'
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf "$1";;
    *.tar.xz) tar Jxvf "$1";;
    *.zip) unzip "$1";;
    *.lzh) lha e "$1";;
    *.tar.bz2|*.tbz) tar xjvf "$1";;
    *.tar.Z) tar zxvf "$1";;
    *.gz) gzip -d "$1";;
    *.bz2) bzip2 -dc "$1";;
    *.Z) uncompress "$1";;
    *.tar) tar xvf "$1";;
    *.arj) unarj "$1";;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
