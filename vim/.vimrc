let mapleader = ","

set ruler
set textwidth=80

set expandtab
set shiftwidth=2
set smarttab
set softtabstop=2
set tabstop=2
set cinoptions+=(0

set autoindent
set autoread
set backspace=indent,eol,start
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

filetype plugin indent on
syntax on

set winwidth=87
set winheight=5
set winminheight=5
set winheight=999

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  au BufReadPost COMMIT_EDITMSG exe "normal! gg"

  au BufRead,BufNewFile */t/t[0-9][0-9][0-9][0-9]-*.sh set syntax=sharness
endif

let g:go_jump_to_error = 0
let g:go_fmt_command = "goimports"
let g:go_template_autocreate = 0
let g:go_version_warning = 0
let g:vim_markdown_folding_disabled = 1

set wildignore+=*.a,*.o,*.so

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
command! -nargs=* Gitc :call MaybeInlineCommand("git.compile always <args>")

nnoremap <c-B> :execute '!TIG_SCRIPT=<(echo :' . line(".") . ') tig blame %'<cr><cr>

nnoremap <c-n> :cn<cr>
nnoremap <c-m> :cp<cr>

nnoremap <silent> <c-h> <c-W><c-h>
nnoremap <silent> <c-j> <c-W><c-j>
nnoremap <silent> <c-k> <c-W><c-k>
nnoremap <silent> <c-l> <c-W><c-l>
nnoremap H gT
nnoremap L gt

map <leader>sc :setlocal spell! spelllang=en_us<cr>

nnoremap <space> :nohl<cr>

nnoremap ; :

nnoremap <c-o> :CtrlPTag<cr>

map <leader>m :copen<cr>:AsyncRun -focus=0 make -j40<cr>

function! TrimWhitespace()
  %s/\s\+$//e
endfunction

"" 4.b) Remove trailing whitespace on events
autocmd FileWritePre   * :call TrimWhitespace()
autocmd FileAppendPre  * :call TrimWhitespace()
autocmd FilterWritePre * :call TrimWhitespace()
autocmd BufWritePre    * :call TrimWhitespace()

match ErrorMsg '\s\+$'

let &t_Cs = "\e[4:3m"
let &t_Ce = "\e[4:0m"

function! s:scheme_customize() abort
  hi Comment      ctermfg=8
  hi Conditional  ctermfg=5
  hi Include      ctermfg=4
  hi PreProc      ctermfg=1
  hi Special      ctermfg=6
  hi StorageClass ctermfg=3
  hi String       ctermfg=2
  hi Structure    ctermfg=5
  hi Type         ctermfg=3
  hi Statement    ctermfg=1
  hi Operator     ctermfg=6
  hi Constant     ctermfg=16

  hi CursorLine  ctermbg=18 cterm=NONE
  hi ColorColumn ctermbg=18 cterm=NONE

  hi GitGutterAdd    ctermfg=2    ctermbg=NONE
  hi GitGutterChange ctermfg=3    ctermbg=NONE
  hi GitGutterDelete ctermfg=1    ctermbg=NONE
  hi SignColumn      ctermfg=0    ctermbg=0

  hi SpellBad   ctermfg=1  ctermbg=0  cterm=undercurl
  hi SpellLocal ctermfg=1  ctermbg=0  cterm=undercurl
  hi SpellCap   ctermfg=1  ctermbg=0  cterm=undercurl
  hi SpellRare  ctermfg=1  ctermbg=0  cterm=undercurl

  hi ErrorMsg   ctermfg=9  ctermbg=0

  hi Pmenu                 ctermbg=248
endfunction

if exists('+termguicolors')
  set notermguicolors
endif

autocmd ColorScheme * call s:scheme_customize()

colorscheme default

autocmd FileType tex hi clear texItalStyle
autocmd FileType tex hi clear texBoldStyle

set timeoutlen=1000 ttimeoutlen=0

set mouse=a
set nowrap

set makeprg=make\ -j$_NPROCESSORS_ONLN\ $VMAKE_OPTIONS
function QuickFixFoundErrors()
  for e in getqflist()
    if e.valid
      return 1
    endif
  endfor
  return 0
endfunction

function VMake()
  silent make
  redraw!
  if ! QuickFixFoundErrors()
    quit
  endif
  cc
endfunction
