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
SBIN="/usr/local/sbin"
export PATH="${NPM}:${GO}:${YARN}:${PG}:${SBIN}:${PATH}"

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
  export FZF_DEFAULT_OPTS="--reverse"
fi

# kubernetes
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# addons
[ -f /usr/local/etc/profile.d/autojump.sh ] && source /usr/local/etc/profile.d/autojump.sh
[ -x "$(command -v nodenv)" ] && eval "$(nodenv init -)"

# general aliases
alias dotfiles="cd ${HOME}/dotfiles"
alias scripts="cd ${HOME}/scripts"
alias ll='ls -aFGhl'
alias ls='ls -aFG'
alias l='exa -lah --git'
alias x='exit'
alias rm='rm -i'
alias tmux='tmux -2'
alias ping='prettyping --nolegend'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias b64='function(){echo $1 | base64}'
alias ub64='function(){echo $1 | base64 -D}'
alias password="head -c 62 /dev/urandom | /usr/bin/base64 -i - -o - | sed 's/[^a-zA-Z0-9]//g'"
alias uuid="uuidgen |tr '[:upper:]' '[:lower:]'"

# git aliases
alias g='git'
alias gc='git clone'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias ga='git add'
alias gd='git diff'
alias gdc='git diff --cached'
alias gp='git pull'
alias gpom='git push origin master'
alias gpot='git push origin --tags'
# git commit browser
gl() {
  git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"  | \
   fzf --ansi --no-sort --reverse --tiebreak=index --preview \
   'f() { set -- $(echo -- "$@" | grep -o "[a-f0-9]\{7\}"); [ $# -eq 0 ] || git show --color=always $1 ; }; f {}' \
   --bind "j:down,k:up,alt-j:preview-down,alt-k:preview-up,ctrl-f:preview-page-down,ctrl-b:preview-page-up,q:abort,ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" --preview-window=right:60%
}

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
function start-session() {
  local selected_profile=$(cat ~/.aws/config| awk '/\[profile.+\]/{ print substr($0, 10, length($0) - 10) }' | fzf --height 30% --reverse -1 -0 --header 'Select Profile')
  command aws-session --profile $selected_profile
}
alias ss='start-session'
alias assume-role='function(){eval $(command assume-role $@);}'
ams() {
  local profile

  profile=$(ls ~/dev/dominium/infrastructure/aws-manage-sg/*.json | fzf)
  aws-manage-sg -u smorrison -f $profile
}

# kubectl aliases
alias k='kubectl'
alias kgn='kubectl get nodes'
alias kgp='kubectl get pods'
alias kgs='kubectl get service'
alias kgi='kubectl get ingress'
alias kgd='kubectl get deployment'
alias kpf='kubectl port-forward'
alias kn='kubens'
alias kc='kubectx'

# helm aliases
HELM="${HOME}/.helm"
HELM_DEV="${HOME}/.helm/dev"
HELM_DEMO="${HOME}/.helm/demo"
HELM_PROD="${HOME}/.helm/prod"
alias hdev="ln -sf ${HELM_DEV}/ca.cert.pem ${HELM}/ca.pem; ln -sf ${HELM_DEV}/helm.cert.pem ${HELM}/cert.pem; ln -sf ${HELM_DEV}/helm.key.pem ${HELM}/key.pem"
alias hdemo="ln -sf ${HELM_DEMO}/ca.cert.pem ${HELM}/ca.pem; ln -sf ${HELM_DEMO}/helm.cert.pem ${HELM}/cert.pem; ln -sf ${HELM_DEMO}/helm.key.pem ${HELM}/key.pem"
alias hprod="ln -sf ${HELM_PROD}/ca.cert.pem ${HELM}/ca.pem; ln -sf ${HELM_PROD}/helm.cert.pem ${HELM}/cert.pem; ln -sf ${HELM_PROD}/helm.key.pem ${HELM}/key.pem"

# fzf aliases
function fssh() {
  local selected_host=$(ag --ignore-case '^host [^*]' ~/.ssh/config | cut -d ' ' -f 2 | fzf --height 30% -1 -0 --header 'Select Host')
  ssh $selected_host
}
# fuzzy search and ssh onto gitlab instances
function fgitlab() {
  local ip
  local natdns

  natdns=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value | \
    [0], PublicDnsName]" \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=nat-az-1 --output text | \
    tr ' ' '-' | \
    column -t -s $'\t' | awk '{print $2}')

  ip=$(aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[Tags[?Key=='Name'].Value | \
    [0], LaunchTime, PublicDnsName,PrivateIpAddress]" \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=gitlab-runner --output text | \
    tr ' ' '-' | \
    column -t -s $'\t' | fzf | awk '{print $4}')

  ssh -i ~/.ssh/keys/dominium-gitlab-runner ubuntu@$ip -o "proxycommand ssh -W %h:%p -i ~/.ssh/keys/dominium-gitlab-runner ec2-user@$natdns"
}
# fuzzy search and describe kubernetes objects
function fkd() {
  local types="pod\nservice\ningress\ndeployment\nstatefulset\nconfigmap\nsecret"
  local object=$(echo $types | fzf)
  local instance

  instance=$(kubectl get $object | fzf | awk '{print $1}')

  if [[ "$object" == "configmap" || "$object" == "secret" ]]; then
    kubectl get $object $instance -oyaml
  else
    kubectl describe $object $instance
  fi
}

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

# update list of installed brews and casks in dotfiles
function update-brews() {
  brew list > ~/dev/dotfiles/.brews
  brew cask list > ~/dev/dotfiles/.casks
}

# dominium aliases
issuerlink() {
  local invitationId

  invitationId=$(echo 'type=ISSUER' | base64)
  echo "invitationId=$invitationId"
}
reviewerlink() {
  local invitationId

  invitationId=$(echo 'type=REVIEWER' | base64)
  echo "invitationId=$invitationId"
}
ownerlink() {
  local invitationId

  invitationId=$(echo 'type=OWNER' | base64)
  echo "invitationId=$invitationId"
}
memberlink() {
  if [[ -z "$1" ]]; then
    echo 'Requires a groupId!'
  else
    local invitationId

    invitationId=$(echo "type=USER&groupId=$1" | base64)
    echo "invitationId=$invitationId"
  fi
}

# prompt
#
# git clone https://github.com/romkatv/powerlevel10k.git ~/dev/powerlevel10k
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_KUBECONTEXT_BACKGROUND='black'
POWERLEVEL9K_KUBECONTEXT_FOREGROUND='white'
POWERLEVEL9K_CUSTOM_AWS_BACKGROUND='yellow'
POWERLEVEL9K_CUSTOM_AWS_FOREGROUND='black'
POWERLEVEL9K_CUSTOM_AWS="custom_aws"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext custom_aws)

# custom aws prompt to display role if assumed
custom_aws() {
  local aws_profile="${AWS_PROFILE:-$AWS_DEFAULT_PROFILE}"

  if [[ ! -z "$ASSUMED_ROLE" ]]; then
    aws_profile="$ASSUMED_ROLE"
  fi

  if [[ -n "$aws_profile" ]]; then
    echo -e "$aws_profile \uf270"
  fi
}

source ~/dev/powerlevel10k/powerlevel10k.zsh-theme

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
