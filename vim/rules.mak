INSTALL_PAIRS += vim .vim
INSTALL_PAIRS += vim/.vimrc .vimrc

ifndef NO_VIM_AUTOUPDATE
POST_INSTALL += vim-plugins

.PHONY : vim-plugins
vim-plugins :
	@$(DESTDIR)/.vim/script/update_pack ttaylorr
endif
