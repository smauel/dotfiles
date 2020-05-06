BREW := /usr/local/bin/brew
AUTHORFILE := $(HOME)/.gitauthor
VSCODE_DIR := $(HOME)/Library/Application\ Support/Code/User

DOTFILES := $(addprefix $(HOME)/,$(shell ls -A home))
SCRIPTS := $(addprefix /usr/local/bin/,$(shell ls -A bin))
VSCODES := $(addprefix $(VSCODE_DIR)/,$(shell ls -A vscode))

# space safe notdir check
s? = $(subst $(empty) ,?,$1)
?s = $(subst ?, ,$1)
notdirx = $(call ?s,$(notdir $(call s?,$1)))

.PHONY: link unlink brew brews vscode help $(VSCODES)

help:
	@cat banner
	@echo 'make all          run all targets'
	@echo 'make link         link dotfiles'
	@echo 'make unlink       unlink dotfiles'
	@echo 'make brews        install all brews, casks and taps'
	@echo 'make vscode       install vscode settings and extensions'
	@echo 'make help         this help message'

all: | link brews vscode

link: | $(DOTFILES) $(SCRIPTS) $(AUTHORFILE)
	mkdir -p $(HOME)/.config/nvim
	@ln -sf "$(PWD)/home/.vimrc" "$(HOME)/.config/nvim/init.vim"

unlink:
	@echo 'unlinking'
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(SCRIPTS); do if [ -h $$f ]; then rm -i $$f; fi; done
	rm $(AUTHORFILE)

brews: | brew
	brew bundle

brew: | $(BREW)
	brew update

vscode: | $(VSCODES)
	while read EXTENSION; do \
	  code --install-extension $${EXTENSION}; \
	done < $(PWD)/vscode/extensions.txt;

$(DOTFILES):
	@ln -sf "$(PWD)/home/$(notdir $@)" $@

$(SCRIPTS):
	@ln -sf "$(PWD)/bin/$(notdir $@)" $@

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

