ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

plugins=(git virtualenv colored-man mvn terminalapp vagrant osx common-aliases)

source $ZSH/oh-my-zsh.sh
source ~/.zsh_aliases

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"
export EDITOR='vim'

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
