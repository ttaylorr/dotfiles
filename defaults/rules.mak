POST_INSTALL += defaults

.PHONY : defaults
defaults :
	defaults write -g KeyRepeat -int 1
	defaults write -g InitialKeyRepeat -int 10
	defaults write -g ApplePressAndHoldEnabled -bool false
