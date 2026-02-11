INSTALL_PAIRS += alacritty/.alacritty.toml .alacritty.toml
INSTALL_PAIRS += alacritty/dark.toml .alacritty.d/themes/dark.toml
INSTALL_PAIRS += alacritty/light.toml .alacritty.d/themes/light.toml

POST_INSTALL += terminfo

.PHONY : terminfo
terminfo :
	infocmp alacritty >/dev/null 2>&1 || tic -x alacritty/alacritty.info
