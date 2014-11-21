" ttaylorr's .vimrc

syntax on

set nocompatible
set backspace=indent,eol,start

set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" Plugins go here
cmap w!! %!sudo tee > /dev/null %

if has("gui_running")
  set columns=80 lines=70
endif

for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor
