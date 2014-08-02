" ttaylorr's .vimrc

syntax on

set backspace=indent,eol,start

cmap w!! %!sudo tee > /dev/null %

if has("gui_running")
  set columns=80 lines=70
endif
