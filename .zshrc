# ============
# PLUGINS
# ============
source /usr/local/share/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle brew
antigen bundle common-aliases
antigen bundle docker-compose
antigen bundle docker
antigen bundle git
antigen bundle npm
antigen bundle osx
antigen bundle thefuck
antigen bundle yarn
antigen apply

PATH="${HOME}/.npm-packages/bin:$PATH"
PATH="$HOME/Library/Python/2.7/bin:$PATH"

. /Users/sam/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

eval $(thefuck --alias)

# ============
# ALIASES
# ============
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
