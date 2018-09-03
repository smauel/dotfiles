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
eval $(thefuck --alias)

autoload -U promptinit; promptinit
prompt pure

# aliases
# general aliases
alias p='./projects'
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias x='exit'
alias rm='rm -i'
alias tmux='tmux -2'
alias cat='bat'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"

# docker aliases
alias d='docker'
alias dc='docker-compose'
alias dupapi='docker-compose up -d api'
alias dlogs='docker-compose logs -f'
alias dlogsapi='docker-compose logs -f api'
alias dps='docker ps'
alias dpa='docker ps --all'
alias di='docker images'
alias drm='docker rm $(docker ps -aq)'
alias dri='docker rmi $(docker images -q)'
alias dstop='docker stop $(docker ps -aq)'
alias dprune='docker system prune && docker volume prune'

# aws aliases
alias mfa-start-session='function(){eval $(command mfa-start-session $@);}'
alias assume-role='function(){eval $(command assume-role $@);}'

# kubectl aliases
alias k='kubectl'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgs='kubectl get service'
alias kgi='kubectl get ingress'
alias kgd='kubectl get deployment'
alias kpf='kubectl port-forward'
alias kctx='kubectl config use-context'

export PATH="$HOME/.yarn/bin:$PATH"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"

# base16 colorschemes
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
eval "$(nodenv init -)"

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # respect .gitignore
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
