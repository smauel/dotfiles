autoload -U promptinit; promptinit
prompt spaceship

# fixes a display issue where ... is displayed at the end of the prompt
export SPACESHIP_PROMPT_ASYNC=false

export EDITOR=nvim
export PATH=~/go/bin:$PATH

alias ll="ls -la --color"
alias cc="clear"
alias x="exit"
alias vim="nvim"

alias gs="git status -s"
alias gd="git diff"
alias gdc="git diff --cached"
alias gap="git add -p"

source /usr/share/nvm/init-nvm.sh
