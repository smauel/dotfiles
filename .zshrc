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

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias vim='/Applications/MacVim.app/Contents/bin/vim'
  export EDITOR='/Applications/MacVim.app/Contents/bin/vim'
  export VISUAL='/Applications/MacVim.app/Contents/bin/mvim'
else
  export EDITOR=/usr/bin/vim
fi

PATH="${HOME}/.npm-packages/bin:$PATH"
PATH="${HOME}/go/bin:$PATH"
eval $(thefuck --alias)

autoload -U promptinit; promptinit
prompt pure

# add kube to prompt
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
PROMPT='$(kube_ps1)'$PROMPT
kubeoff

# aliases
# general aliases
alias p='./projects'
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias x='exit'
alias rm='rm -i'
alias tmux='tmux -2'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"

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

# terraform aliases
# alias terraform='function(){command terraform $@ | landscape}'

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

eval "$(nodenv init -)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # respect .gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
