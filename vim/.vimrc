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
set conceallevel=0
set cursorline
set hlsearch
set incsearch
set lazyredraw
set nomodeline
set noswapfile
set smartindent
set spell
set ttyfast
set wildmenu
filetype plugin on
syntax on

"" 1.d) Minimum window sizes
set winwidth=87
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

"" 1.e) remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

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
if executable('rg')
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ackprg = 'rg --vimgrep --no-heading'
endif

"" 2.a.d) vim-better-sml
au Filetype sml setlocal conceallevel=2

au Filetype dafny setlocal conceallevel=2
if has('conceal') && &enc == 'utf-8'
  au Filetype dafny syntax match dafnyElementOperator "\<in\>" conceal cchar=∈
endif

"" 3.e) Smart tab completion (http://vim.wikia.com/wiki/VimTip102)
function! Smart_TabComplete()
  if pumvisible() != 0
    return "\<C-P>"
  endif

  let line = getline('.')
  let substr = matchstr(strpart(line, -1, col('.')+1), "[^ \t]*$")

  if (strlen(substr) == 0)
    return "\<tab>"
  endif

  let has_delimeter = match(substr, '\.') != -1 || match(substr, '::') != -1
  let has_slash = match(substr, '\/') != -1

  if (!has_delimeter && !has_slash)
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
nnoremap <Leader>a :Ack!<Space>''<Left>
set completeopt+=menuone
set completeopt-=preview

function InlineCommand(cmd)
  let l:output = system(a:cmd)
  let l:output = substitute(' '.l:output, '[\r\n]*$', '', '')
  execute 'normal i' . l:output
endfunction

command! -nargs=* Git :call InlineCommand("git always <args>")

let g:livepreview_previewer = 'open -a Skim'

if strlen(system("which racer")) > 0
  let g:racer_cmd = system("echo -n $HOME") . "/.cargo/bin/racer"
  let g:racer_experimental_completer = 1

  if strlen(system("which rustfmt")) > 0
    let g:rustfmt_autosave = 1
  endif
endif

autocmd FileType java setlocal omnifunc=javacomplete#Complete

function! UpdateImports()
  :call javacomplete#imports#AddMissing()
endfunction

autocmd BufWritePre *.java :call UpdateImports()
" nmap <leader>jI :call UpdateImports()
" imap <C-j>I     :call UpdateImports()

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
autocmd FileType go map <leader>t  :GoTestFunc<cr>
autocmd FileType go map <leader>tt :GoTest<cr>
autocmd FileType go map <leader>tc :GoCoverage<cr>
autocmd FileType go map <leader>ta :Tagbar<cr>
autocmd FileType go map <leader>ga :GoAlternate<cr>
autocmd FileType go map <leader>gd :GoDoc<cr>

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

"" 3.i) map `,to` to open tag buffer
map <leader>to :TagbarOpen<cr>

"" 3.j) map `,m` to make
map <leader>m :term ++close ++rows=5 make<cr>

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
colorscheme Atelier_ForestLight

set number

"" 5.b) Tab deletion with ^w.
noremap <C-w> :tabclose<CR>

"" 5.c) Remove annoying escape delay
set timeoutlen=1000 ttimeoutlen=0

"" 5.d) Macvim
autocmd! GUIEnter * set vb t_vb=
autocmd! GUIEnter * set guifont=Fira\ Code\ Retina:h16
autocmd VimResized * redraw!

if system("echo $TERM_PROGRAM") == "iTerm.app"
  set mouse=a
endif
