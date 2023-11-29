INSTALL_PAIRS += bin/best-of-five .bin/best-of-five
INSTALL_PAIRS += bin/git-apply-to .bin/git-apply-to
INSTALL_PAIRS += bin/git-curl .bin/git-curl
INSTALL_PAIRS += bin/git-find-topic .bin/git-find-topic
INSTALL_PAIRS += bin/git-format-config .bin/git-format-config
INSTALL_PAIRS += bin/git-lore .bin/git-lore
INSTALL_PAIRS += bin/git-ls-unreachable .bin/git-ls-unreachable
INSTALL_PAIRS += bin/git-mail .bin/git-mail
INSTALL_PAIRS += bin/git-mail-deliver .bin/git-mail-deliver
INSTALL_PAIRS += bin/git-ownership .bin/git-ownership
INSTALL_PAIRS += bin/git-print-patch .bin/git-print-patch
INSTALL_PAIRS += bin/git-reroll .bin/git-reroll
INSTALL_PAIRS += bin/git-sequence .bin/git-sequence
INSTALL_PAIRS += bin/git-unwip--editor .bin/git-unwip--editor
INSTALL_PAIRS += bin/git-who .bin/git-who
INSTALL_PAIRS += bin/iplog .bin/iplog
INSTALL_PAIRS += bin/tailserve .bin/tailserve
INSTALL_PAIRS += bin/unwrap .bin/unwrap
ifneq ("$(wildcard bin/shard)","")
INSTALL_PAIRS += bin/shard .bin/shard
endif

ifdef MACOS
INSTALL_PAIRS += bin/edit-clipboard .bin/edit-clipboard
INSTALL_PAIRS += bin/yabai-readjust-vertical .bin/yabai-readjust-vertical
endif

INSTALL_PAIRS += $(HOME)/src/git/contrib/git-jump/git-jump .bin/git-jump

bin/diff-highlight :
	make -C $(HOME)/src/git/contrib/diff-highlight
	ln -s $(HOME)/src/git/contrib/diff-highlight/diff-highlight $@
PRE_INSTALL += bin/diff-highlight

INSTALL_PAIRS += bin/diff-highlight .bin/diff-highlight
