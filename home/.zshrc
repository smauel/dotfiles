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
source $HOME/.zsh/exports.zsh
source $HOME/.zsh/path.zsh
source $HOME/.zsh/aliases.zsh
source $HOME/.zsh/fzf.zsh
source $HOME/.zsh/gitauthor.zsh
source $HOME/.secrets.zsh

. /usr/local/opt/asdf/libexec/asdf.sh
