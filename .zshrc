NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

if [ -d "$HOME/Library/Python/2.7/bin" ]; then
    PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

. /Users/sam/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

alias ..='cd ../'
alias ...='cd ../../'
alias ll='ls -Gal'
alias x='exit'
# tmux
alias tls='tmux list-sessions'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
