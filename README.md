# dotfiles

![](screenshot.png)

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

Where possible features have been split out into separate files and the `.zshrc`
sources them.

Some notable features:

* Uses [starship](https://starship.rs) for prompt customization
* Uses Nord for dir colors to match theme
* Configures a number of aliases for common operations (see `home/.zsh/aliases`)

### Neovim

Uses [packer](https://github.com/wbthomason/packer.nvim) for plugin management.
On first load packer _should_ install itself and then auto install all plugins.
If for some reason plugins are not installed they can be installed by running
`:PackerInstall` from within neovim.

All plugins that are installed can be viewed in `config/nvim/lua/plugins.lua`

All keymappings that are configured can be viewed in `config/nvim/lua/keymappings.lua`
(although `which-key` is also installed which will provide a handy prompt)

### Tmux

Tmux configuration can be found in `home/.tmux.conf`. Prefix is set to `<C-a>`

Uses
[tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) and
[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) for automatic session
restore on startup. Current tmux session state can be saved with `<prefix>+<C-s>`

### Kitty

Uses [kitty](https://sw.kovidgoyal.net/kitty/) for terminal emulation. Config
can be found in `config/kitty`

### Colors

Uses the excellent `nord` theme for vim, tmux and kitty.

### Git Author

Will create a `~/.gitauthor` file in the home directory which exports git author
information

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

### VSCode

VSCode settings, keybindings and extensions configurations can be found under `vscode`

### IntelliJ

IntelliJ settings are exported to the zip file in `intellij`. See the README for
details on how to import and update

### Secrets

For any secrets that you need to export into your shell these can be exported
from a file called `~/.secrets`:

```bash
export MY_SECRET=xxx
```

This file will be imported by `~/.zshrc` but is not included in source control
