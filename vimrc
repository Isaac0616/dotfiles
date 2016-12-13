""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   basic                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set number
set autoindent
set smartindent
set cinwords=if,else,while,do,for,switch,case
set ruler
set showmode
set showcmd
set showmatch
set backspace=indent,eol,start
set iskeyword-=*
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set ignorecase
set smartcase

" disable comment continuation
set formatoptions-=cro

" no timeout except ESC
set ttimeout
set ttimeoutlen=20
set notimeout

" persistent undo
set undodir=~/.vim/undodir
set undofile

" swap directory
set directory=~/.vim/swap

" backup directory
set backup
set backupdir=~/.vim/backup

" viminfo lacation
set viminfo+=n~/.vim/viminfo

let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       auto save and restore folding                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             file type specific                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType pug setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} let g:DeleteTrailingWhitespace=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  mapping                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick reload .vimrc
map <leader>ss :source ~/.vimrc<CR>

" toggle tagbar
map <silent> <F6> :TagbarToggle<cr>

" toggle highlight search
noremap <F8> :set hlsearch! hlsearch?<CR>

" folding
nmap <silent> <leader>izf vi}zf%<CR>
nmap <silent> <leader>zf va}zf%<CR>

" TODO: improve fold text
"set foldtext=MyFoldText()
    "set fillchars=fold:\ "space
"function! MyFoldText()
    "let nl = v:foldend - v:foldstart + 1
    "let txt = substitute(getline(v:foldstart), "^ ", "+", 1)
    "return txt
"endfunction

" toggle location list
noremap <silent> <leader>lc :lcl<CR>
noremap <silent> <leader>lo :lw<CR>

" tab shortcut
map <leader>tn :tabnew<cr>
map <leader>te :tabedit<space>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<space>
map <leader>to :tabonly<cr>
map <leader>tg :tabn<space>

" toggle arrow behavior between buffer and tab
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

" move between spliting windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" move page
map <UP> <C-E>
map <DOWN> <C-Y>

" move lines
if has("macunix")
    execute "set <A-j>=\ej"
    execute "set <A-k>=\ek"
endif

noremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

" multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" paste last copy
map <leader>p "0p
map <leader>P "0P

" cd to current file's directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vim-plug                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" automatic installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'Isaac0616/vim-colors-solarized'
Plug 'lazywei/vim-doc-tw'
Plug 'scrooloose/syntastic'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'DeleteTrailingWhitespace'
Plug 'digitaltoad/vim-pug'
Plug 'jiangmiao/auto-pairs'
Plug 'vim-scripts/Tagbar'
Plug 'mru.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'kana/vim-fakeclip'
Plug 'Shougo/neocomplete.vim'
Plug 'tmhedberg/matchit'
"Plug 'haya14busa/incsearch.vim'

"Plug 'snipMate'
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'tpope/vim-fugitive'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plugin setting                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" solarized
syntax on
set background=dark
let g:solarized_termcolors=16
colorscheme solarized
hi CursorLineNr ctermbg=0 ctermfg=10

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#close_symbol = ''
let g:airline_theme='solarized'

" easymotion
let g:EasyMotion_leader_key = '<Leader>'

" undotree
nnoremap <F7> :UndotreeToggle<cr>

" NERDTree
map <F9> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" syntastic
let g:syntastic_java_javac_config_file_enabled = 1
"let g:syntastic_python_python_exe = 'python3'

" ctags
set tags=./tags;

" cscope
" cscope commands:
" add  : Add a new database             (Usage: add file|dir [pre-path] [flags])
" find : Query for a pattern            (Usage: find c|d|e|f|g|i|s|t name)
      " c: Find functions calling this function
      " d: Find functions called by this function
      " e: Find this egrep pattern
      " f: Find this file
      " g: Find this definition
      " i: Find files #including this file
      " s: Find this C symbol
      " t: Find assignments to
" help : Show this message              (Usage: help)
" kill : Kill a connection              (Usage: kill #)
" reset: Reinit all connections         (Usage: reset)
" show : Show connections               (Usage: show)

" function! LoadCscope()
  " let db = findfile("cscope.out", ".;")
  " if (!empty(db))
    " let path = strpart(db, 0, match(db, "/cscope.out$"))
    " set nocscopeverbose " suppress 'duplicate connection' error
    " exe "cs add " . db . " " . path
    " set cscopeverbose
  " endif
" endfunction
" au BufEnter /* call LoadCscope()

" if has('cscope')
  " set cscopeverbose

  " if has('quickfix')
    " set cscopequickfix=g-,s-,c-,d-,i-,t-,e-
  " endif

  " nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
  " nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  " nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
  " nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
  " nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
  " nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
  " nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
  " nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" endif

" neocomplcache
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 1
inoremap <expr><Tab>
\ neocomplete#complete_common_string() != '' ?
\   neocomplete#complete_common_string() :
\ pumvisible() ? "\<C-n>" : "\<Tab>"
set completeopt-=preview
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" YankRing
nnoremap <silent> <F10> :YRShow<CR>
let g:yankring_history_dir = '~/.vim'

" Delete trailing whitespace
let g:DeleteTrailingWhitespace = 1
let g:DeleteTrailingWhitespace_Action = 'delete'

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" " incsearch
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)

" MRU
let MRU_File = $HOME . '/.vim/vim_mru_files'
