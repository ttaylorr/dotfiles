DOTFILES_ROOT := $(shell pwd)

all: bash zsh brew git vim tmux editorconfig karabiner
.PHONY: bash zsh brew git vim tmux editorconfig karabiner

brew:
	ln -fs $(DOTFILES_ROOT)/brew/Brewfile ${HOME}/.Brewfile
	brew bundle --global

git:
	ln -fs $(DOTFILES_ROOT)/git/.gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES_ROOT)/git/.gitignore ${HOME}/.gitignore

vim:
	$(call install-if-missing, "vim")
	[ ! -L ${HOME}/.vim ] && ln -Ffs $(DOTFILES_ROOT)/vim/ ${HOME}/.vim || true
	$(DOTFILES_ROOT)/vim/script/update_pack ttaylorr
	ln -fs $(DOTFILES_ROOT)/vim/.vimrc ${HOME}/.vimrc

editorconfig:
	ln -fs $(DOTFILES_ROOT)/editorconfig/.editorconfig ${HOME}/.editorconfig

karabiner:
	$(DOTFILES_ROOT)/karabiner/import.sh

tmux:
	$(call install-if-missing, "tmux")
	mkdir -p ${HOME}/.tmux/plugins
	ln -fs $(DOTFILES_ROOT)/tmux/tpm ${HOME}/.tmux/plugins/
	ln -fs $(DOTFILES_ROOT)/tmux/.tmux.conf ${HOME}/.tmux.conf

zsh:
	$(call install-if-missing, "zsh")
	ln -fs $(DOTFILES_ROOT)/zsh/.zshrc ${HOME}/.zshrc

bash:
	ln -fs $(DOTFILES_ROOT)/bash/.bash_profile ${HOME}/.bash_profile

define install-if-missing
	@brew list $1 > /dev/null 2>&1 || brew install $1
endef
