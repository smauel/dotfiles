autoload -U promptinit; promptinit
prompt spaceship

# fixes a display issue where ... is displayed at the end of the prompt
export SPACESHIP_PROMPT_ASYNC=false

alias ll="ls -la --color"
alias cc="clear"
alias x="exit"
alias vim="nvim"

alias gs="git status -s"
alias gd="git diff"
alias gdc="git diff --cached"
alias gap="git add -p"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
