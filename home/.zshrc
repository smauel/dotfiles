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
# fasd
#
eval "$(fasd --init auto)"

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

#
# asdf
#
# MUST come after $PATH has been set
#
# TODO: write script to init asdf on clean install
#   - install plugins if not installed
#   - install versions specified in .tool-versions
source /opt/homebrew/opt/asdf/libexec/asdf.sh

