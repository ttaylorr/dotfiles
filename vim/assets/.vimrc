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
set ruler
set number

" Reasonable space delimeters
set tabstop=2
set shiftwidth=2
set softtabstop=2

set smarttab
set expandtab
set hlsearch

" Better pane switching
set splitright

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

" Plug Stuff
call plug#begin('~/.vim/plugged')

Plug 'kien/ctrlp.vim'
Plug 'chriskempson/base16-vim'
Plug 'thoughtbot/vim-rspec'
Plug 'editorconfig/editorconfig-vim'
Plug 'pangloss/vim-javascript'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'Shougo/neocomplcache.vim'
Plug 'fatih/vim-go'
Plug 'editorconfig/editorconfig-vim'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'

call plug#end()

let g:neocomplcache_enable_at_startup = 1

let ctrlp_custom_ignore = 'node_modules/|bower_components/'

map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1

" Colors!
set cursorline
set background=dark
colorscheme base16-ocean

" Better tab-completion mappings
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col-1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

" rspec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

" testing with npm
map <Leader>nt :!npm test<CR>

noremap <Leader>b :!rake<CR>

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

noremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<CR>

function! NumberToggle()
  set number

  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

noremap <C-n> :call NumberToggle()<CR>

cmap w!! %!sudo tee > /dev/null %

" Remap arrow-keys to no-ops
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor
