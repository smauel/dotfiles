BIN_DIR := /usr/local/bin
VSCODE_DIR := $(HOME)/Library/Application\ Support/Code/User
CONFIG_DIR := $(HOME)/.config
AUTHORFILE := $(HOME)/.gitauthor
BREW := $(BIN_DIR)/brew
TMUX_RESURRECT := ~/dev/tmux-resurrect
TMUX_CONTINUUM := ~/dev/tmux-continuum

DOTFILES := $(addprefix $(HOME)/,$(shell ls -A home))
SCRIPTS := $(addprefix $(BIN_DIR)/,$(shell ls -A bin))
CONFIG := $(addprefix $(CONFIG_DIR)/,$(shell ls config))
VSCODES := $(addprefix $(VSCODE_DIR)/,$(shell ls -A vscode))

# space safe notdir check
s? = $(subst $(empty) ,?,$1)
?s = $(subst ?, ,$1)
notdirx = $(call ?s,$(notdir $(call s?,$1)))

.PHONY: all link unlink brew brews brewfile vscode help $(DOTFILES) $(SCRIPTS) $(CONFIG) $(VSCODES)

help:
	@cat banner
	@echo 'make all          run all targets'
	@echo 'make link         link dotfiles'
	@echo 'make unlink       unlink dotfiles'
	@echo 'make brews        install all brews, casks and taps'
	@echo 'make brewfile     update Brewfile'
	@echo 'make vscode       install vscode settings and extensions'
	@echo 'make help         this help message'

all: | brews link vscode

link: | $(DOTFILES) $(SCRIPTS) $(CONFIG) $(AUTHORFILE)

unlink:
	@echo 'unlinking'
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(SCRIPTS); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(CONFIG); do if [ -h $$f ]; then rm -i $$f; fi; done
	@if [ -f $(AUTHOR_FILE) ]; then rm -i $(AUTHORFILE); fi

brewfile: | brew
	brew bundle dump --force --describe

brews: | brew
	brew bundle --no-upgrade

brew: | $(BREW)
	brew update

vscode: | $(VSCODES)
	while read EXTENSION; do \
	  code --install-extension $${EXTENSION} --force; \
	done < $(PWD)/vscode/extensions.txt;

$(DOTFILES): $(TMUX_CONTINUUM) $(TMUX_RESURRECT)
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/home/$(notdir $@)" $@

$(TMUX_CONTINUUM):
	@echo "cloning tmux-continuum"
	git clone https://github.com/tmux-plugins/tmux-continuum.git $(TMUX_CONTINUUM)

$(TMUX_RESURRECT):
	@echo "cloning tmux-resurrect"
	git clone https://github.com/tmux-plugins/tmux-resurrect.git $(TMUX_RESURRECT)

$(SCRIPTS):
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/bin/$(notdir $@)" $@

$(CONFIG):
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/config/$(notdir $@)" $@

$(AUTHORFILE):
	@read -p "What is your git author name? " NAME; \
  echo "export GIT_AUTHOR_NAME=\"$${NAME}\"" > "$(AUTHORFILE)"; \
  echo "export GIT_COMMITTER_NAME=\"$${NAME}\"" >> "$(AUTHORFILE)";
	@read -p "What is your git author email? " EMAIL; \
  echo "export GIT_AUTHOR_EMAIL=$${EMAIL}" >> "$(AUTHORFILE)"; \
  echo "export GIT_COMMITTER_EMAIL=$${EMAIL}" >> "$(AUTHORFILE)"; \

$(VSCODES):
	@ln -sf "$(PWD)/vscode/$(call notdirx,$@)" "$@"

$(BREW):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

