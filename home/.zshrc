autoload -Uz compinit
compinit

#
# History
#
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Options
#
setopt AUTO_CD                 # [default] .. is shortcut for cd .. (etc)
setopt AUTO_PARAM_SLASH        # tab completing directory appends a slash
setopt SHARE_HISTORY           # share history across shells

#
# fzf
#
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# fasd
#
eval "$(fasd --init auto)"

#
# nvm
#
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# starship
#
eval "$(starship init zsh)"

#
# Source other configuration
#
source $HOME/.zsh/exports
source $HOME/.zsh/path
source $HOME/.zsh/aliases
source $HOME/.zsh/fzf
source $HOME/.zsh/gitauthor
source $HOME/.secrets
