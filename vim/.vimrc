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

let g:LanguageClient_serverCommands = {
  \   'go': ['gopls'],
  \ }
let g:LanguageClient_diagnosticsEnable = 0

function! MyGoToDefinition(...) abort
  " ref: https://github.com/davidhalter/jedi-vim/blob/master/pythonx/jedi_vim.py#L329-L345

  " Get the current position
  let l:fname = expand('%:p')
  let l:line = line(".")
  let l:col = col(".")
  let l:word = expand("<cword>")

  " Call the original function to jump to the definition
  let l:result = LanguageClient_runSync(
                  \ 'LanguageClient#textDocument_definition', {
                  \ 'handle': v:true,
                  \ })

  " Get the position of definition
  let l:jump_fname = expand('%:p')
  let l:jump_line = line(".")
  let l:jump_col = col(".")

  " If the position is the same as previous, ignore the jump action
  if l:fname == l:jump_fname && l:line == l:jump_line
    return
  endif

  " Workaround: Jump to origial file. If the function is in rust, there is a
  " way to ignore the behaviour
  if &modified
    exec 'hide edit'  l:fname
  else
    exec 'edit' l:fname
  endif
  call cursor(l:line, l:col)

  " Store the original setting
  let l:ori_wildignore = &wildignore
  let l:ori_tags = &tags

  " Write a temp tags file
  let l:temp_tags_fname = tempname()
  let l:temp_tags_content = printf("%s\t%s\t%s", l:word, l:jump_fname,
      \ printf("call cursor(%d, %d)", l:jump_line, l:jump_col+1))
  call writefile([l:temp_tags_content], l:temp_tags_fname)

  " Set temporary new setting
  set wildignore=
  let &tags = l:temp_tags_fname

  " Add to new stack
  execute ":tjump " . l:word

  " Restore original setting
  let &tags = l:ori_tags
  let &wildignore = l:ori_wildignore

  " Remove temporary file
  if filereadable(l:temp_tags_fname)
    call delete(l:temp_tags_fname, "rf")
  endif
endfunction

function LC_maps()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    set completefunc=LanguageClient#complete
    set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    nnoremap <buffer> <silent> <C-]> :call MyGoToDefinition()<cr>

    autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
  endif

endfunction

autocmd FileType * call LC_maps()

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

set number

"" 5.b) Tab deletion with ^w.
noremap <C-w> :tabclose<CR>

"" 5.c) Remove annoying escape delay
set timeoutlen=1000 ttimeoutlen=0
