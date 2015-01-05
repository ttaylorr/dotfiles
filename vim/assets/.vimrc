" ttaylorr's .vimrc
set nocompatible

" Turn on syntax highlighting
syntax on

" Allow backspacing anywhere
set backspace=indent,eol,start

" Remap the leader key
let mapleader=","

" Word-processing-type stuff
set textwidth=80
set colorcolumn=+1
set ruler

" Reasonable space delimeters
set tabstop=2
set shiftwidth=2
set softtabstop=2

set smarttab
set expandtab

" Better pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Better handling of errant whitespace
match ErrorMsg '\s\+$'

function! TrimWhitespace()
  %s/\s\+$//e
endfunction

" Map <Leader>rt to remove trailing whitespace
noremap <silent> <Leader>rt :call TrimWhitespace()<CR>

" Remove trailing whitespace before several operations
autocmd FileWritePre   * :call TrimWhitespace()
autocmd FileAppendPre  * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre    * :call TrimWhitespace()

" Vundle Stuff
set rtp+=~/.vim/bundle/Vundle.vim
filetype off
call vundle#begin()

Plugin 'kien/ctrlp.vim'
Plugin 'chriskempson/base16-vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-scripts/TeX-PDF'

call vundle#end()
filetype plugin indent on

" Colors!
set cursorline
set background=dark
colorscheme base16-ocean

" rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

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
