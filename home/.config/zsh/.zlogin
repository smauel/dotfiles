if [[ -z $DISPLAY && $TTY = /dev/tty1 ]]; then
  exec /usr/bin/sway
fi
