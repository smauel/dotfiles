# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch
unsetopt beep notify
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# path
NPM="${HOME}/.npm-packages/bin"
GO="${HOME}/go/bin"
YARN="$HOME/.yarn/bin"
PG="/usr/local/opt/postgresql@9.6/bin"
SBIN="/usr/local/sbin"
export PATH="${NPM}:${GO}:${YARN}:${PG}:${SBIN}:${PATH}"

# editor
if [[ "$OSTYPE" == "darwin"* ]]; then
  export EDITOR=$(which vim)
  export VISUAL=$(which mvim)
else
  export EDITOR=$(which vim)
fi

# source git author details from file
[ -f $HOME/.gitauthor ] && source $HOME/.gitauthor

# fzf
if [ -f ~/.fzf.zsh ]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' # respect .gitignore
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_DEFAULT_OPTS="--reverse"
fi

# kubernetes
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# addons
[ -x "$(command -v nodenv)" ] && eval "$(nodenv init -)"

# aliases
[ -f ~/.aliases ] && source ~/.aliases

# prompt
# git clone https://github.com/romkatv/powerlevel10k.git ~/dev/powerlevel10k
POWERLEVEL9K_MODE='nerdfont-complete'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_last
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=''
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=' '
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_KUBECONTEXT_BACKGROUND='black'
POWERLEVEL9K_KUBECONTEXT_FOREGROUND='white'
POWERLEVEL9K_CUSTOM_AWS_BACKGROUND='yellow'
POWERLEVEL9K_CUSTOM_AWS_FOREGROUND='black'
POWERLEVEL9K_CUSTOM_AWS="custom_aws"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="❯ "
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext custom_aws)

# custom aws prompt to display role if assumed
custom_aws() {
  local aws_profile="${AWS_PROFILE:-$AWS_DEFAULT_PROFILE}"

  if [[ ! -z "$ASSUMED_ROLE" ]]; then
    aws_profile="$ASSUMED_ROLE"
  fi

  if [[ -n "$aws_profile" ]]; then
    echo -e "$aws_profile \uf270"
  fi
}

source ~/dev/powerlevel10k/powerlevel10k.zsh-theme

man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
