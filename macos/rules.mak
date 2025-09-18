ifdef MACOS

PRE_INSTALL += macos/dark-mode-notify/.build/arm64-apple-macosx/release/dark-mode-notify
macos/dark-mode-notify/.build/arm64-apple-macosx/release/dark-mode-notify :
	make -C macos/dark-mode-notify

POST_INSTALL += dark-mode-notify-reload
.PHONY : dark-mode-notify-reload
dark-mode-notify-reload :
	launchctl load -w ~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist

INSTALL_PAIRS += macos/dark-mode-notify/.build/arm64-apple-macosx/release/dark-mode-notify \
		 .bin/dark-mode-notify
INSTALL_PAIRS += macos/ke.bou.dark-mode-notify.plist \
		 Library/LaunchAgents/ke.bou.dark-mode-notify.plist

endif
