""basic""
set nocompatible
set number
set autoindent
set smartindent
"set cindent
set cinwords=if,else,while,do,for,switch,case
set ruler
set showmode
set showcmd
set showmatch
set backspace=indent,eol,start
"set iskeyword+=_,$,@,#,%,&,*
set iskeyword-=*
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
"set autoread
set incsearch
"set ignorecase smartcase
set smartcase

let mapleader = ","

autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"Automatically append closing brace
""imap {<TAB> {<CR>}<Esc>O

""source""
map <leader>ss :source ~/.vimrc<CR>

""function key""
noremap <F8> :set hlsearch! hlsearch?<CR>

""fold""
nmap <silent> <leader>izf vi}zf%<CR>
nmap <silent> <leader>zf va}zf%<CR>
"set foldtext=MyFoldText()
    "set fillchars=fold:\ "space
"function! MyFoldText()
    "let nl = v:foldend - v:foldstart + 1
    "let txt = substitute(getline(v:foldstart), "^ ", "+", 1)
    "return txt
"endfunction

""location list""
noremap <silent><leader>lc :lcl<CR>
noremap <silent><leader>lo :lw<CR>

""buffer""
map <leader>bn :bn<cr>
map <leader>bp :bp<cr>

""tab""
map <leader>tn :tabnew<cr>
map <leader>te :tabedit<space>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<space>
map <leader>to :tabonly<cr>
map <leader>tg :tabn<space>

""toggle arrow behavior between buffer and tab""
function! BufferOrTabNext()
    if tabpagenr("$") > 1
        exe "tabnext"
    else
        exe "bnext"
    endif
endfunction

function! BufferOrTabPre()
    if tabpagenr("$") > 1
        exe "tabprevious"
    else
        exe "bprevious"
    endif
endfunction

map <right> :call BufferOrTabNext()<CR>
map <left> :call BufferOrTabPre()<CR>

""spliting windows""
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

""move page""
map <UP> <C-E>
map <DOWN> <C-Y>

""move lines""
"noremap <A-j> :m+<CR>==
"nnoremap <A-k> :m-2<CR>==
"inoremap <A-j> <Esc>:m+<CR>==gi
"inoremap <A-k> <Esc>:m-2<CR>==gi
"vnoremap <A-j> :m'>+<CR>gv=gv
"vnoremap <A-k> :m-2<CR>gv=gv
noremap ∆ :m+<CR>==
nnoremap ˚ :m-2<CR>==
inoremap ∆  <Esc>:m+<CR>==gi
inoremap ˚ <Esc>:m-2<CR>==gi
vnoremap ∆ :m'>+<CR>gv=gv
vnoremap ˚ :m-2<CR>gv=gv

""allow multiple indentation/deindentation in visual mode""
vnoremap < <gv
vnoremap > >gv

"timeout
set ttimeout
set ttimeoutlen=20
set notimeout

" Set the command window height to 2 lines, to avoid many cases of having to
" " "press <Enter> to continue"
" set cmdheight=2

""paste""
"map <leader>p "0p
"map <leader>P "0P

""fix terminal arrow key""
"nmap [A <up>
"nmap [B <down>
"nmap [C <right>
"nmap [D <left>

"" change working directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

""Remove trailing whitespace when writing a buffer, but not for diff files.
""From: Vigil
""@see http://blog.bs2.to/post/EdwardLee/17961
function! RemoveTrailingWhitespace()
    if &ft != "diff"
    let b:curcol = col(".")
    let b:curline = line(".")
    silent! %s/\s\+$//
    silent! %s/\(\s*\n\)\+\%$//
call cursor(b:curline, b:curcol)
    endif
endfunction
autocmd BufWritePre * call RemoveTrailingWhitespace()

""highlight""
"hi CursorLine ctermbg=234 cterm=none

""Persistent undo""
set undodir=~/.vim/undodir
set undofile

""swap directory""
set directory=~/.vim/swap



""Bundle""
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

""Bundle 'Valloric/YouCompleteMe'
""Bundle 'lornix/vim-scrollbar'
""Bundle 'xuhdev/SingleCompile'
"Bundle 'tpope/vim-surround'
""Bundle 'matrix.vim--Yang'
""Bundle 'xterm-color-table.vim'
"Bundle 'vim-scripts/SearchComplete'
"Bundle 'vim-scripts/taglist.vim'
"Bundle 'mru.vim'
"Bundle 'vim-scripts/CCTree'
"Bundle 'edkolev/promptline.vim'
Bundle 'The-NERD-Commenter'
"Bundle 'snipMate'
Bundle 'altercation/vim-colors-solarized'
"Bundle 'vim-scripts/AutoComplPop'
Bundle 'lazywei/vim-doc-tw'
Bundle 'scrooloose/syntastic'
Bundle 'vimez/vim-showmarks'
Bundle 'vim-scripts/Tagbar'
Bundle 'mbbill/undotree'
Bundle 'scrooloose/nerdtree'
Bundle 'kana/vim-fakeclip'
"Bundle 'spf13/vim-autoclose'
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'kien/ctrlp.vim'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'jiangmiao/auto-pairs'
Bundle 'tmhedberg/matchit'
Bundle 'maxbrunsfeld/vim-yankstack'
Bundle 'vim-scripts/YankRing.vim'
Bundle 'kien/rainbow_parentheses.vim'
"Bundle 'vim-scripts/Conque-Shell'
"Bundle 'carlobaldassi/ConqueTerm'

filetype plugin indent on


"solarized
syntax on
set background=dark
let g:solarized_termcolors=16
colorscheme solarized
hi CursorLineNr ctermbg=0 ctermfg=10

"airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#close_symbol = ''

"easymotion
let g:EasyMotion_leader_key = '<Leader>'

"taglist
"let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_GainFocus_On_ToggleOpen = 1
"let Tlist_Show_One_File = 1
"map <silent> <F6> :TlistToggle<cr>

"tagbar toggle
map <silent> <F6> :TagbarToggle<cr>

"undotree
nnoremap <F7> :UndotreeToggle<cr>

"NERDTree
map <F9> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

"syntastic
let g:syntastic_java_javac_config_file_enabled = 1

"ctags
set tags=./tags;

"cscope
"cscope commands:
"add  : Add a new database             (Usage: add file|dir [pre-path] [flags])
"find : Query for a pattern            (Usage: find c|d|e|f|g|i|s|t name)
"       c: Find functions calling this function
"       d: Find functions called by this function
"       e: Find this egrep pattern
"       f: Find this file
"       g: Find this definition
"       i: Find files #including this file
"       s: Find this C symbol
"       t: Find assignments to
"help : Show this message              (Usage: help)
"kill : Kill a connection              (Usage: kill #)
"reset: Reinit all connections         (Usage: reset)
"show : Show connections               (Usage: show)

function! LoadCscope()
  let db = findfile("cscope.out", ".;")
  if (!empty(db))
    let path = strpart(db, 0, match(db, "/cscope.out$"))
    set nocscopeverbose " suppress 'duplicate connection' error
    exe "cs add " . db . " " . path
    set cscopeverbose
  endif
endfunction
au BufEnter /* call LoadCscope()

if has('cscope')
  set cscopeverbose

  if has('quickfix')
    set cscopequickfix=g-,s-,c-,d-,i-,t-,e-
  endif

  nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
endif

"autoclose
let g:autoclose_vim_commentmode = 1

"neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_enable_auto_select = 1
inoremap <expr><TAB> pumvisible() ? (empty(neocomplcache#complete_common_string()) ? "\<C-n>" : neocomplcache#complete_common_string()) : "\<TAB>"

"Yankring
let g:yankring_replace_n_pkey = '<leader>p'
let g:yankring_replace_n_nkey = '<leader>P'
nnoremap <silent> <F10> :YRShow<CR>
let g:yankring_history_dir = '~/.vim'

"RainbowParentheses
":RainbowParenthesesToggle       " Toggle it on/off
":RainbowParenthesesLoadRound    " (), the default when toggling
":RainbowParenthesesLoadSquare   " []
":RainbowParenthesesLoadBraces   " {}
":RainbowParenthesesLoadChevrons " <>
