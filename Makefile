BREW := /usr/local/bin/brew
VIM_PLUG := $(HOME)/.config/nvim/autoload/plug.vim
AUTHORFILE := $(HOME)/.gitauthor
VSCODE_DIR := $(HOME)/Library/Application\ Support/Code/User
COC_DIR := $(HOME)/.config/coc

DOTFILES := $(addprefix $(HOME)/,$(shell ls -A home))
SCRIPTS := $(addprefix /usr/local/bin/,$(shell ls -A bin))
VSCODES := $(addprefix $(VSCODE_DIR)/,$(shell ls -A vscode))
NVIMS := $(addprefix $(HOME)/.config/nvim/,$(shell ls -A nvim))

# space safe notdir check
s? = $(subst $(empty) ,?,$1)
?s = $(subst ?, ,$1)
notdirx = $(call ?s,$(notdir $(call s?,$1)))

.PHONY: link unlink brew brews vscode coc help $(DOTFILES) $(SCRIPTS) $(NVIMS) $(VSCODES)

help:
	@cat banner
	@echo 'make all          run all targets'
	@echo 'make link         link dotfiles'
	@echo 'make unlink       unlink dotfiles'
	@echo 'make brews        install all brews, casks and taps'
	@echo 'make vscode       install vscode settings and extensions'
	@echo 'make help         this help message'

all: | link brews vscode

link: | $(DOTFILES) $(SCRIPTS) $(NVIMS) $(AUTHORFILE) coc

unlink:
	@echo 'unlinking'
	@for f in $(DOTFILES); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(SCRIPTS); do if [ -h $$f ]; then rm -i $$f; fi; done
	@for f in $(NVIMS); do if [ -h $$f ]; then rm -i $$f; fi; done
	@if [ -h $(COC_DIR) ]; then rm -ri $(COC_DIR); fi
	@if [ -f $(AUTHOR_FILE) ]; then rm -i $(AUTHORFILE); fi

brews: | brew
	brew bundle

brew: | $(BREW)
	brew update

vscode: | $(VSCODES)
	while read EXTENSION; do \
	  code --install-extension $${EXTENSION}; \
	done < $(PWD)/vscode/extensions.txt;

coc:
	@echo "- linking coc"
	@ln -sfn "$(PWD)/coc" $(COC_DIR)
	@echo "- installing coc extensions"
	@cd $(PWD)/coc; yarn

$(DOTFILES):
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/home/$(notdir $@)" $@

$(SCRIPTS):
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/bin/$(notdir $@)" $@

$(NVIMS): | $(VIM_PLUG)
	@echo "- $(notdir $@)"
	@ln -sfn "$(PWD)/nvim/$(notdir $@)" $@

$(VIM_PLUG):
	curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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

