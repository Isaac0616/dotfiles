""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   basic                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
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
set lazyredraw
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set ignorecase
set smartcase
set hidden
set colorcolumn=80
set completeopt-=preview

" split
" set splitbelow
set splitright

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

" Save cursor loation and folder setting.
" Backslashes in file names replaced with forward slashes.
" With Unix end-of-line format, even when on Windows or DOS.
set viewoptions=cursor,folds,slash,unix

" disable auto insert comment in new lines
autocmd FileType * setlocal fo-=c fo-=r fo-=o

let mapleader = ","


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                             file type specific                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType html,pug,json,javascript,css setlocal shiftwidth=2 tabstop=2
autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} let g:DeleteTrailingWhitespace=0
autocmd FileType *.{md,mdown,mkd,mkdn,markdown,mdwn} setlocal spell spelllang=en_us


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  mapping                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick reload .vimrc
map <leader>ss :source ~/.vimrc<CR>

" toggle tagbar
map <silent> <F6> :TagbarToggle<cr>

" toggle highlight search
noremap <F8> :set hlsearch! hlsearch?<CR>

" toogle paste mode
noremap <F4> :set paste! paste?<CR>

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
" noremap <silent> <leader>lc :lcl<CR>
" noremap <silent> <leader>lo :lw<CR>

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
" map <C-j> <C-W>j
" map <C-k> <C-W>k
" map <C-h> <C-W>h
" map <C-l> <C-W>l

" move page
map <UP> <C-E>
map <DOWN> <C-Y>

" move lines
" if has("macunix")
    " execute "set <A-j>=\ej"
    " execute "set <A-k>=\ek"
" endif

" noremap <A-j> :m+<CR>==
" nnoremap <A-k> :m-2<CR>==
" inoremap <A-j> <Esc>:m+<CR>==gi
" inoremap <A-k> <Esc>:m-2<CR>==gi
" vnoremap <A-j> :m'>+<CR>gv=gv
" vnoremap <A-k> :m-2<CR>gv=gv

" multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" paste last copy
map <leader>p "0p
map <leader>P "0P

" cd to current file's directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %


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
" Plug 'lazywei/vim-doc-tw'
Plug 'w0rp/ale'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/DeleteTrailingWhitespace'
Plug 'digitaltoad/vim-pug'
" Plug 'jiangmiao/auto-pairs'
Plug 'Raimondi/delimitMate'
Plug 'majutsushi/tagbar'
" Plug 'vim-scripts/Tagbar'
Plug 'vim-scripts/mru.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'kana/vim-fakeclip'
" Plug 'Shougo/neocomplete.vim'
Plug 'tmhedberg/matchit'
" Plug 'Yggdroot/indentLine'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mileszs/ack.vim'
" Plug 'ronakg/quickr-preview.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-multiple-cursors'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/restore_view.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'yuttie/comfortable-motion.vim'
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
Plug 'matze/vim-move'
Plug 'Valloric/ListToggle'
Plug 'christoomey/vim-tmux-navigator'
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'jsfaint/gen_tags.vim'
Plug 'vim-scripts/Mark--Karkat'

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer --js-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" Plug 'hari-rangarajan/CCTree'
" Plug 'wesleyche/SrcExpl'
" Plug 'abudden/taghighlight-automirror'
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
" Plug 'haya14busa/incsearch.vim'

"Plug 'snipMate'
"Plug 'tpope/vim-fugitive'
" Plug 'edkolev/tmuxline.vim'

call plug#end()


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plugin setting                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" solarized
syntax on
set background=dark
let g:solarized_termcolors=16
silent! colorscheme solarized
hi CursorLineNr ctermbg=0 ctermfg=10
set fillchars+=vert:│
hi VertSplit ctermbg=NONE guibg=NONE

" airline
" command: :AirlineToggleWhitespace
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

" ctags
" command: ctags -R
" command: ctags -R --fields=+l --c-kinds=+p --c++-kinds=+p
" Use g] instead of C-] to get the list of all matches
set tags=./tags;
nnoremap <F1> <C-W>}
nnoremap <silent> <F2> :pclose<CR>

" cscope
" cscope command: cscope -Rbq
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

if has('cscope')
  set cscopeverbose

  if has('quickfix')
    set cscopequickfix=s-,c-,d-,i-,t-,e-
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

" neocomplcache
" let g:acp_enableAtStartup = 0
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_smart_case = 1
" let g:neocomplete#enable_auto_select = 1
" inoremap <expr><Tab>
" \ neocomplete#complete_common_string() != '' ?
" \   neocomplete#complete_common_string() :
" \ pumvisible() ? "\<C-n>" : "\<Tab>"
" set completeopt-=preview
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
" use // for c language
let g:NERDAltDelims_c = 1
" use '#' instead of '# ' for python
let g:NERDAltDelims_python = 1

" " incsearch
" map /  <Plug>(incsearch-forward)
" map ?  <Plug>(incsearch-backward)

" MRU
let MRU_File = $HOME . '/.vim/vim_mru_files'

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <F3> :Ack! <cword> %<CR>

" delimitMate
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_nesting_quotes = ['"', '`', "'"]

" Startify
hi StartifyHeader  ctermfg=2
hi StartifyBracket ctermfg=10
hi StartifyPath    ctermfg=10
hi StartifySlash   ctermfg=10

" tmuxline
" let g:tmuxline_preset = {
      " \'a'    : '#S',
      " \'win'  : '#I #W',
      " \'cwin' : '#I #W',
      " \'x'    : '%a',
      " \'y'    : ['%Y-%m-%d', '%R'],
      " \'z'    : '#H',
      " \'options': {
        " \'status-justify': 'left'}
      " \}

" ale
let g:ale_python_flake8_executable = 'python2'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
" let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
\   'python': ['flake8'],
\}

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_max_num_candidates = 20
let g:ycm_semantic_triggers = {
\ 'c,cpp,python,javascript': [ 're!\w{2}' ]
\}

" vim-indent-guides
nmap <silent> <Leader>ig :IndentGuidesToggle<CR>
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" gen_tags
let g:gen_tags#gtags_auto_gen = 1

" Mark--Karkat
nmap <Plug>NoMarkSearchCurrentPrev <Plug>MarkSearchCurrentPrev
nmap <Plug>NoMarkSearchCurrentNext <Plug>MarkSearchCurrentNext
