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
set cinoptions+=(0

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

let g:go_jump_to_error = 0
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

function MaybeInlineCommand(cmd)
  let l:lines = split(system(a:cmd), '\n')
  if len(l:lines) == 0
    " nothing to do
  elseif len(l:lines) == 1
    " We have one line; let's append it at the cursor, but with a little
    " magic for inserting into existing prose:
    "  - if we're in the middle of a word, insert at the end of the word
    "  - insert spaces to separate from existing content (unless we
    "    already have them)
    if col('.') > 1 && getline('.')[col('.')-1] != ' '
      " Not just 'e', because that will go to the next word if we're on
      " the last letter of the current one.
      execute 'normal he'
      let l:lines[0] = ' ' . l:lines[0]
    endif
    if col('.') != col('$')-1 && getline('.')[col('.')] != ' '
      let l:lines[0] = l:lines[0] . ' '
    endif
    execute 'normal a' . l:lines[0]
  else
    call append(line('.'), l:lines)
  endif
endfunction

command! -nargs=* Git :call MaybeInlineCommand("git always <args>")


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
nnoremap <silent> <c-h> <c-W><c-h>
nnoremap <silent> <c-j> <c-W><c-j>
nnoremap <silent> <c-k> <c-W><c-k>
nnoremap <silent> <c-l> <c-W><c-l>

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

autocmd FileType tex hi clear texItalStyle
autocmd FileType tex hi clear texBoldStyle

hi SpellBad ctermbg=224

set number

"" 5.b) Tab deletion with ^w.
noremap <C-w> :tabclose<CR>

"" 5.c) Remove annoying escape delay
set timeoutlen=1000 ttimeoutlen=0
