autoload -U compinit && compinit

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# zsh plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# set path
if [[ ! "$PATH" == */home/smauel/.local/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/smauel/.local/bin"
fi
if [[ ! "$PATH" == */home/smauel/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/smauel/.fzf/bin"
fi
if [[ ! "$PATH" == */home/smauel/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/smauel/bin"
fi
if [[ ! "$PATH" == */home/smauel/go/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/smauel/go/bin"
fi
if [[ ! "$PATH" == */usr/local/go/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/go/bin"
fi

# keybindings
bindkey -e

# history
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt auto_cd
setopt auto_param_slash

# completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# shell integration
source <(fzf --zsh)
# eval "$(zoxide init --cmd cd zsh)"

# aliases
alias ll="ls -la --color"
alias x="exit"
alias cc="clear"
alias gs="git status -s"
alias gd="git diff"
alias gdc="git diff --cached"
alias gap="git add -p"
alias vim="nvim"
alias vi="nvim"

export GOBIN="/home/smauel/go/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
