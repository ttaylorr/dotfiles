" ttaylorr's .vimrc

" Turn on syntax highlighting
syntax on

" Allow backspacing anywhere
set nocompatible
set backspace=indent,eol,start

" Remap the leader key
let mapleader=","

" Reasonable space delimeters
set tabstop=4
set shiftwidth=3
set softtabstop=4

set smarttab
set expandtab

" Vundle Stuff
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" Map <leader>f to use selecta
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

noremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

cmap w!! %!sudo tee > /dev/null %

" Remap arrow-keys to no-ops
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor
