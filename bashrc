if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

#env variables
export PS1="\u@\h \W \$ "
export PATH=/usr/local/bin:$PATH
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_51.jdk/Contents/Home

# dir and file coloring
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

source ~/.bash_aliases
