stow -t ~ bin
stow -t ~ home
stow -t ~/.config config

if [ ! -d ~/.config/tmux/plugins/tpm/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
