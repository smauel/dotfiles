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
# asdf
#
# TODO: write script to init asdf on clean install
#   - install plugins if not installed
#   - install versions specified in .tool-versions
source /usr/local/opt/asdf/libexec/asdf.sh
source ~/.asdf/plugins/java/set-java-home.zsh

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
