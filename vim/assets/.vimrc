" ttaylorr's .vimrc

syntax on

cmap w!! %!sudo tee > /dev/null %

if has("gui_running")
  set columns=80 lines=70
endif
