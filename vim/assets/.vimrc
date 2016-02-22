"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 1) General tweaks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

"" 1.a) Text styling
set textwidth=80
set ruler
set number

"" 1.b) Tab preferences (prefer .editorconfig)
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

"" 1.c) Misc. preferences
set cursorline
set hlsearch
set backspace=indent,eol,start
syntax on


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 2) Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 2.a) Initalize plugin manager
call plug#begin('~/.vim/plugged')

"" 2.b) Hook in all plugins
Plug 'airblade/vim-gitgutter'
Plug 'chriskempson/base16-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'kien/ctrlp.vim'
Plug 'pbrisbin/vim-mkdir'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/neocomplcache.vim'
Plug 'tpope/vim-endwise'

"" 2.c) Done!
call plug#end()

"" 2.d) Plugin-level customization
"" 2.d.a) NERDTree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

"" 2.d.b) vim-go (use goimports)
let g:go_fmt_command = "goimports"

"" 2.d.c) ctrlp.vim
set wildignore+=*/node_modules/*,*/bower_components/*


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 3) Key rebindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 3.a) Disable arrow keys
for prefix in ['i', 'n', 'v']
  for key in ['<Up>', '<Down>', '<Left>', '<Right>']
    exe prefix . "noremap " . key . " <Nop>"
  endfor
endfor

"" 3.b) Pane-switching
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
"" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"" 3.c) Testing
map <leader>tu :!./script/test<cr>
map <leader>ti :!./script/integration<cr>
map <leader>tci :!./script/cibuild<cr>

"" 3.d) Spell-Checking
map <leader>sc :setlocal spell! spelllang=en_us<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 4) Formatting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 4.a) Trailing whitespace
function! TrimWhitespace()
  %s/\s\+$//e
endfunction

"" 4.b) Remove trailing whitespace on events
autocmd FileWritePre   * :call TrimWhitespace()
autocmd FileAppendPre  * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre    * :call TrimWhitespace()

"" 4.c) Mark trailing whitespace as an error
match ErrorMsg '\s\+$'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 5) Misc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 5.a) Colorscheme
set background=dark
colorscheme torte

"" 5.b) Relative/absolute number switch with <C-n>
function! NumberToggle()
  set number

  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction
noremap <C-n> :call NumberToggle()<CR>
