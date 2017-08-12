# plugins
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
eval $(thefuck --alias)

antigen theme agnoster
# aliases
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
