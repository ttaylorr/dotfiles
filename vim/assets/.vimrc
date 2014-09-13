" ttaylorr's .vimrc

syntax on

set backspace=indent,eol,start

cmap w!! %!sudo tee > /dev/null %

if has("gui_running")
  set columns=80 lines=70
endif

for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor
