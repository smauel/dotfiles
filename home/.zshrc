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

#
# asdf
#
# MUST come after $PATH has been set
#
# TODO: write script to init asdf on clean install
#   - install plugins if not installed
#   - install versions specified in .tool-versions
source /opt/homebrew/opt/asdf/libexec/asdf.sh


# pnpm
export PNPM_HOME="/Users/smauel/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm endexport HOMEBREW_GITHUB_API_TOKEN=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
