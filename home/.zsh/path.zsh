SYSTEM_PATH=$PATH
unset PATH

PATH=$HOME/bin
PATH=$HOME/.local/bin
PATH=$PATH:/usr/local/bin
PATH=$PATH:/usr/local/sbin
PATH=$PATH:$SYSTEM_PATH
PATH=$PATH:$GOBIN

export PATH
