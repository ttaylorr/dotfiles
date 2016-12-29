"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 1) General tweaks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader = ","

"" 1.a) Text styling
set number
set ruler
set textwidth=80

"" 1.b) Tab preferences (prefer .editorconfig)
set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2

"" 1.c) Misc. preferences
set autoindent
set backspace=indent,eol,start
set cursorline
set hlsearch
set incsearch
set lazyredraw
set nomodeline
set smartindent
set ttyfast
syntax on

"" 1.d) Minimum window sizes
set winwidth=87
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 2) Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" 2.a) Plugin-level customization
"" 2.a.a) NERDTree
map <C-o> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

"" 2.a.b) vim-go (use goimports)
let g:go_fmt_command = "goimports"
let g:go_template_autocreate = 0

"" 2.a.c) ctrlp.vim
set wildignore+=*/node_modules/*,*/bower_components/*

"" 3.e) Smart tab completion (http://vim.wikia.com/wiki/VimTip102)
"" HACK: manually set omnifunc for Go files.
autocmd BufRead,BufNewFile *.go setlocal omnifunc=go#complete#Complete

function! Smart_TabComplete()
  if pumvisible() != 0
    return "\<C-P>"
  endif

  let line = getline('.')
  let substr = matchstr(strpart(line, -1, col('.')+1), "[^ \t]*$")

  if (strlen(substr) == 0)
    return "\<tab>"
  endif

  let has_period = match(substr, '\.') != -1
  let has_slash = match(substr, '\/') != -1

  if (!has_period && !has_slash)
    return "\<C-X>\<C-P>"
  elseif (has_slash)
    return "\<C-X>\<C-F>"
  else
    return "\<C-X>\<C-O>"
  endif
endfunction

function! Smart_ShiftTab()
  if pumvisible() != 0
    return "\<C-N>"
  endif

  return "\<C-d>"
endfunction

inoremap <tab> <c-r>=Smart_TabComplete()<CR>
inoremap <s-tab> <c-r>=Smart_ShiftTab()<CR>
set completeopt+=menuone
set completeopt-=preview
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

"" 3.c.i) Testing (Golang)
autocmd FileType go map <leader>t  :GoTest<cr>
autocmd FileType go map <leader>tt :GoTestFunc<cr>
autocmd FileType go map <leader>tc :GoCoverage<cr>
autocmd FileType go map <leader>ga :GoAlternate<cr>

"" 3.d) Spell-Checking
map <leader>sc :setlocal spell! spelllang=en_us<cr>

"" 3.e) Quickly disable hlsearch
nnoremap <space> :nohl<cr>

"" 3.f) Tab switching
nnoremap H gT
nnoremap L gt

"" 3.g) ; -> :
nnoremap ; :

"" 3.h) map `,r` to redraw! buffer
map <leader>r :redraw!<cr>

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
set background=light
colorscheme base16-atelierforest

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

"" 5.c) Selecta (credit: github.com/garybernhardt/selecta)
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

nnoremap <c-p> :call SelectaCommand("find * -type f", "", ":e")<cr>

"" 5.d) Remove annoying escape delay
set timeoutlen=1000 ttimeoutlen=0
