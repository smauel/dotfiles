BREW := /usr/local/bin/brew
AUTHORFILE := $(HOME)/.gitauthor
VSCODE_DIR := $(HOME)/Library/Application\ Support/Code/User

DOTFILES := $(addprefix $(HOME)/,$(shell ls -A home))
SCRIPTS := $(addprefix /usr/local/bin/,$(shell ls -A bin))
VSCODES := $(addprefix $(VSCODE_DIR)/,$(shell ls -A vscode))
NVIMS := $(addprefix $(HOME)/.config/nvim/,$(shell ls -A nvim))

# space safe notdir check
s? = $(subst $(empty) ,?,$1)
?s = $(subst ?, ,$1)
notdirx = $(call ?s,$(notdir $(call s?,$1)))

.PHONY: link unlink brew brews vscode help $(DOTFILES) $(SCRIPTS) $(NVIMS) $(VSCODES)

help:
	@cat banner
	@echo 'make all          run all targets'
	@echo 'make link         link dotfiles'
	@echo 'make unlink       unlink dotfiles'
	@echo 'make brews        install all brews, casks and taps'
	@echo 'make vscode       install vscode settings and extensions'
	@echo 'make help         this help message'

all: | link brews vscode

link: | $(DOTFILES) $(SCRIPTS) $(NVIMS) $(AUTHORFILE)

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
	@echo "- $(notdir $@)"
	@ln -sf "$(PWD)/home/$(notdir $@)" $@

$(SCRIPTS):
	@echo "- $(notdir $@)"
	@ln -sf "$(PWD)/bin/$(notdir $@)" $@

$(NVIMS):
	@echo "- $(notdir $@)"
	@ln -sf "$(PWD)/nvim/$(notdir $@)" $@

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

