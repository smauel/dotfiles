BINFILES := $(shell ls -A bin)
HOMEFILES := $(shell ls -A home)
DOTFILES := $(addprefix $(HOME)/,$(HOMEFILES))
SCRIPTS := $(addprefix /usr/local/bin/,$(BINFILES))
BREW := /usr/local/bin/brew
AUTHORFILE := $(addprefix $(HOME)/,.gitauthor)

.PHONEY: link unlink brew brews help

help:
	@cat banner
	@echo 'make all          run all targets'
	@echo 'make link         link dotfiles'
	@echo 'make brews        install all brews, casks and taps'
	@echo 'make help         this help message'

all: | link brews

link: | $(DOTFILES) $(SCRIPTS) $(AUTHORFILE)
	mkdir -p $(HOME)/.config/nvim
	@ln -sf "$(PWD)/home/.vimrc" "$(HOME)/.config/nvim/init.vim"

brews: | brew
	brew bundle

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

unlink:
	@echo 'unlinking'
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(SCRIPTS); do if [ -h $$f ]; then rm -i $$f; fi; done
	rm $(AUTHORFILE)

brew: | $(BREW)
	brew update

$(BREW):
	@ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

