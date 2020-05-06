# dotfiles

## Installing

To install everything:

```bash
make all
```

Or to run the dotfile linker only:

```bash
make link
```

For full list of commands available run: 

```bash
make help
```

## Customizations

### Zsh

All zsh configuration can be found in `home/.zsh` and `home/.zshrc`.

Where possible features have been split out into separate files and the `.zshrc` sources them.

Some notable features:

* Uses [p10k](https://github.com/romkatv/powerlevel10k) for prompt customization
* Uses Nord for dir colors to match theme
* Configures a number of aliases for common operations (see `home/.zsh/aliases`)

### Vim

Vim configuration can be found in `home/.vimrc`. At link time this is also symlinked to `~/.config/nvim/init.vim` for NVim use.

Uses [vim-plug](https://github.com/junegunn/vim-plug) for plugin management. A small set of plugins are installed including:

* The Nord theme
* Airline for status line
* FZF for fuzzy-finding
* Coc for LSP integrations

For a full list of bindings that are configured see the `home/.vimrc`

### Colors

Uses the excellent [Nord](https://www.nordtheme.com/) theme for vim and iTerm.

For other ports see [here](https://www.nordtheme.com/ports)

### Git Author

Will create a `~/.gitauthor` file in the home directory which exports git author information

```bash
GIT_AUTHOR_NAME="Your Name"
GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
git config --global user.name "$GIT_AUTHOR_NAME"
GIT_AUTHOR_EMAIL="email@you.com"
GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
git config --global user.email "$GIT_AUTHOR_EMAIL"
```

### Homebrew

An included `Brewfile` will install `brews`, `casks` and `taps`. 

To regenerate the `Brewfile` run:

```bash
cd <this repo>
brew bundle dump
```

### iTerm2

Double-clicking the `nord.itermcolors` file will load the colors. 

Then go to `Settings` -> `Profiles` -> `Colors` -> `Color Presets...` and select `nord`

### VSCode

VSCode settings, keybindings and extensions configurations can be found under `vscode`
