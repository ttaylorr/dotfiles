INSTALL_PAIRS += bin/best-of-five .bin/best-of-five
INSTALL_PAIRS += bin/git-apply-to .bin/git-apply-to
INSTALL_PAIRS += bin/git-diff-fancy .bin/git-diff-fancy
INSTALL_PAIRS += bin/git-lore .bin/git-lore
INSTALL_PAIRS += bin/git-ls-unreachable .bin/git-ls-unreachable
INSTALL_PAIRS += bin/git-mail .bin/git-mail
INSTALL_PAIRS += bin/git-ownership .bin/git-ownership
INSTALL_PAIRS += bin/git-print-patch .bin/git-print-patch
INSTALL_PAIRS += bin/git-reroll .bin/git-reroll
INSTALL_PAIRS += bin/git-sequence .bin/git-sequence
INSTALL_PAIRS += bin/git-who .bin/git-who
INSTALL_PAIRS += bin/iplog .bin/iplog
INSTALL_PAIRS += bin/unwrap .bin/unwrap
ifneq ("$(wildcard bin/shard)","")
INSTALL_PAIRS += bin/shard .bin/shard
endif

ifdef MACOS
INSTALL_PAIRS += bin/edit-clipboard .bin/edit-clipboard
INSTALL_PAIRS += bin/git-jump.macos .bin/git-jump
else
INSTALL_PAIRS += bin/git-jump.linux .bin/git-jump
endif
