DOTFILES_ROOT := $(shell pwd)

all: zsh git vim tmux editorconfig
.PHONY: zsh git vim tmux editorconfig

git:
	ln -fs $(DOTFILES_ROOT)/git/.gitconfig ${HOME}/.gitconfig
	ln -fs $(DOTFILES_ROOT)/git/.gitignore ${HOME}/.gitignore

vim:
	$(call install-if-missing, "vim")
	$(call curl-to-location,\
		~/.vim/autoload/plug.vim,\
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim)
	vim +PlugInstall +qall > /dev/null 2>&1
	ln -fs $(DOTFILES_ROOT)/vim/.vimrc ${HOME}/.vimrc

editorconfig:
	ln -fs $(DOTFILES_ROOT)/editorconfig/.editorconfig ${HOME}/.editorconfig

tmux:
	$(call install-if-missing, "pstree")
	ln -fs $(DOTFILES_ROOT)/tmux/.tmux.conf ${HOME}/.tmux.conf

zsh:
	ln -fs $(DOTFILES_ROOT)/zsh/.zshrc ${HOME}/.zshrc

define install-if-missing
	@brew list $1 > /dev/null 2>&1 || brew install $1
endef

define curl-to-location
	@if ! [ -f $1 ]; then \
		curl -fLo $1 --create-dirs $(2) -s; \
	fi
endef
