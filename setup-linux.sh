if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

if [ ! -d ~/.sdkman ]; then
  curl -s "https://get.sdkman.io" | bash
fi

if [ ! -d ~/.nvm ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

stow -t ~ zsh
stow -t ~ alacritty
stow -t ~ tmux
stow -t ~ nvim
stow -t ~ bin
stow -t ~ git
stow -t ~ ripgrep
stow -t ~ repos
