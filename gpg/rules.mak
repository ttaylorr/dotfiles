ifdef MACOS
INSTALL_PAIRS += gpg/gpg-agent.conf.macos .gnupg/gpg-agent.conf
else
INSTALL_PAIRS += gpg/gpg-agent.conf.linux .gnupg/gpg-agent.conf
INSTALL_PAIRS += gpg/scdaemon.conf.linux .gnupg/scdaemon.conf
endif
