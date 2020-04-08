install : brew

.PHONY : brew
brew : brew/Brewfile
	brew bundle --file="$<"
