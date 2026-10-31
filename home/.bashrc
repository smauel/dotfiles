#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# history
HISTCONTROL='ignoredups'
HISTSIZE=5000
HISTFILESIZE=5000

# environemnt variables
export EDITOR='vim'
export GREP_COLOR='1;36'
export LSCOLORS='ExGxbEaECxxEhEhBaDaCaD'
export MANPAGER='less'
export PAGER='less'
export TZ='Europe/London'
export VISUAL='vim'
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--preview-window hidden'
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# less colors
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;33;44m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4;1;32m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'
export LESS_TERMCAP_ZN=$'\e[74m'
export LESS_TERMCAP_ZV=$'\e[75m'
export LESS_TERMCAP_ZO=$'\e[73m'
export LESS_TERMCAP_ZW=$'\e[75m'

# path
export PATH="${HOME}/.local/bin:${PATH}"

# shell options
shopt -s cdspell
shopt -s checkwinsize
shopt -s extglob
shopt -s autocd
shopt -s dirspell

alias ls='ls -p --color=auto'
alias ll='ls -lap --color=auto'
alias grep='grep --color=auto'
alias x='exit'
alias cc='clear'
alias g='git'
alias gs='git st'
alias gd='git df'
alias gds='git dfs'
alias gl='git lg'
alias gap='git ap'
alias ll='ls -la'

alias mcp='mvn clean package'
alias mci='mvn clean install'
alias mcv='mvn clean verify'

# sys-agnostic copy
copy() {
    pbcopy 2>/dev/null ||
        wl-copy 2>/dev/null ||
        xsel 2>/dev/null
}

# truecolor test
rainbow() {
    local i r g b
    for ((i = 0; i < 77; i++)); do
        r=$((255 - (i * 255 / 76)))
        g=$((i * 510 / 76))
        b=$((i * 255 / 76))
        ((g > 255)) && g=$((510 - g))
        printf '\033[48;2;%d;%d;%dm ' "$r" "$g" "$b"
    done
    printf '\e[0m\n'
}

# prompt
prompt-set-theme() {
    local theme=${1:-0}
    local j=0

    # di=directory, ln=symlink, ex=executable
    local ls_di=""
    local ls_ln=""
    local ls_ex=""

    for ((i = theme; i <= 255; i += 30)); do
        PROMPT_COLORS[j]=$'\e[38;5;'${i}m

        # set ls colors to match prompt theme
        case $j in
            0) ls_di="di=38;5;${i}" ;;
            1) ls_ln="ln=38;5;${i}" ;;
            2) ls_ex="ex=38;5;${i}" ;;
        esac

        ((j++))
    done

    export LS_COLORS="${ls_di}:${ls_ln}:${ls_ex}:"
}

prompt-init() {
    local red=$'\e[31m'
    local reset=$'\e[0m'
    local bold=$'\e[1m'

    # Construct the prompt:
    # [(exit code)] <user> - <hostname> <cwd> [git branch] <$|#>

    # exit code of last process
    PS1='$(c=$?;((c!=0))&&echo "\['"$red"'\]($c) \['"$reset"'\]")'

    # username (red for root)
	PS1+='\[${PROMPT_COLORS[0]}\]\['"$bold"'\]'
	PS1+='$(((UID==0))&&echo "\['"$red"'\]")\u\['"$reset"'\]'
    PS1+='\[${PROMPT_COLORS[1]}\]\['"$bold"'\]@\['"$reset"'\]'

    # hostname
    PS1+='\[${PROMPT_COLORS[3]}\]\h '

    # cwd
    PS1+='\[${PROMPT_COLORS[5]}\]\w '

    # optional git branch
    PS1+='$(b=$(git rev-parse --abbrev-ref HEAD 2>/dev/null);[[ -n $b ]]'
    PS1+='&&echo -n "\[${PROMPT_COLORS[2]}\](\[${PROMPT_COLORS[3]}\]'
    PS1+='git:$b\[${PROMPT_COLORS[2]}\]) ")'

    # prompt character
    PS1+='\[${PROMPT_COLORS[0]}\]\$\['"$reset"'\] '

    # initalize a basic theme just to ensure some colors are set
    prompt-set-theme 0
}

prompt-update() {
    local user=$USER
    local host=${HOSTNAME%%.*}

    # get the PWD from the prompt as that handles escaping dangerous chars
    # for us
    local s='\w'
    local pwd=${s@P}

    # update title bar
    local ssh=
    [[ -n $SSH_CLIENT ]] && ssh='[ssh] '
    printf '\e]0;%s%s@%s:%s\a' "$ssh" "$user" "$host" "$pwd"
}

PROMPT_COLORS=()
PROMPT_COMMAND=prompt-update
PROMPT_DIRTRIM=2

prompt-init
prompt-set-theme 29

source "$HOME/.bash_completion"
