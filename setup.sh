if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

stow -t ~ bin
stow -t ~ home
stow -t ~/.config config
