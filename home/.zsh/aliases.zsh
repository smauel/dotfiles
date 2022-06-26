# general aliases
alias dotfiles="cd ${REPOS_DIR}/dotfiles"
alias vim=lvim
alias fv='vim $(fzf)'
alias cc='clear'
alias x='exit'
alias rm='rm -i'
alias grep='grep --color=auto'

# exa aliases
alias ls='exa --group-directories-first --icons --color-scale'
alias lt='exa --tree --icons --git --git-ignore --all --ignore-glob=.git'
alias l='ls -a'
alias ld='ls -D'
alias ll='ls -lb --git'
alias la='ll -a'
alias lC='la --sort=changed'
alias lM='la --sort=modified'
alias lS='la --sort=size'
alias lX='la --sort=extension'

# useful aliases
alias b64='function(){echo $1 | base64}'
alias ub64='function(){echo $1 | base64 -D}'
alias password="head -c 62 /dev/urandom | /usr/bin/base64 -i - -o - | sed 's/[^a-zA-Z0-9]//g'"
alias uuid="uuidgen |tr '[:upper:]' '[:lower:]'"

# git aliases
alias gap='git add --patch'
alias gs='git status -s'
alias gd='git diff'

# docker aliases
alias dc='docker-compose'
alias dcl='docker-compose -f docker-compose.local.yml'
alias drm='docker rm $(docker ps -aq)'
alias dri='docker rmi $(docker images -q)'
alias dstop='docker stop $(docker ps -aq)'
alias dprune='docker system prune && docker volume prune'

# kubernetes aliases
alias k='kubectl'

# OS X has no `md5sum` or `sha1sum`, so setup fallbacks
command -v md5sum > /dev/null || alias md5sum="md5"
command -v sha1sum > /dev/null || alias sha1sum="shasum"

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
