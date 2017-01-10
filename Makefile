DOTFILES_ROOT := $(shell pwd)

all: bash zsh brew bin launchagents git vim tmux editorconfig offlineimap msmtp mutt hammerspoon
.PHONY: bash zsh brew bin launchagents git vim tmux editorconfig offlineimap msmtp mutt hammerspoon

brew:
	ln -fs $(DOTFILES_ROOT)/brew/Brewfile ${HOME}/.Brewfile
	brew bundle --global

bin:
	[ ! -h ${HOME}/.bin ] && ln -fs $(DOTFILES_ROOT)/bin ${HOME}/.bin || true

launchagents:
	ln -fs $(DOTFILES_ROOT)/launchagents/com.ttaylorr.offlineimap.plist ${HOME}/Library/LaunchAgents/com.ttaylorr.oflineimap.plist

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

offlineimap:
	ln -fs $(DOTFILES_ROOT)/offlineimap/.offlineimaprc ${HOME}/.offlineimaprc
	ln -fs $(DOTFILES_ROOT)/offlineimap/.offlineimap.py ${HOME}/.offlineimap.py

msmtp:
	ln -fs $(DOTFILES_ROOT)/msmtp/.msmtprc ${HOME}/.msmtprc

mutt:
	ln -fs $(DOTFILES_ROOT)/mutt/.muttrc ${HOME}/.muttrc
	ln -fs $(DOTFILES_ROOT)/mutt/signature ${HOME}/.mutt/signature

hammerspoon:
	defaults write -g KeyRepeat -int 1
	defaults write -g InitialKeyRepeat -int 10
	[ ! -L ${HOME}/.hammerspoon ] && ln -Fs $(DOTFILES_ROOT)/hammerspoon ${HOME}/.hammerspoon || true

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
