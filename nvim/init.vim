""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   basic                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
set number
set cinwords=if,else,while,do,for,switch,case
set smartindent
set iskeyword-=*
" set lazyredraw
set tabstop=4
set shiftwidth=4
set expandtab
set ignorecase
set hidden
set colorcolumn=100
set completeopt-=preview
set wildmode=longest:full,full
set undofile
set backup
set backupdir=~/.local/share/nvim/backup
" set splitright
set virtualedit=block
set mouse=


" move vertically by visual line
nnoremap j gj
nnoremap k gk

" disable comment continuation
" set formatoptions-=cro

" Don't auto-wrap a line but allow `gq` to wrap the line manually
set textwidth=100
set formatoptions-=t

" no timeout except ESC
" set ttimeout
" set ttimeoutlen=20
" set notimeout

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
autocmd FileType html,pug,json,javascript,javascriptreact,css,typescript,typescriptreact,yaml setlocal shiftwidth=2 tabstop=2
autocmd FileType markdown EnableWhitespace
autocmd FileType markdown DisableStripWhitespaceOnSave
autocmd FileType markdown setlocal spell spelllang=en_us
autocmd BufNewFile,BufRead *.pyst,*.pyst-include setlocal filetype=python

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  folding                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldnestmax=5
set foldlevelstart=3
set foldminlines=5
set foldignore=

autocmd FileType c,cpp,vim,html,javascript,typescript,go,java setlocal foldmethod=syntax
autocmd FileType python,ruby setlocal foldmethod=indent
" autocmd BufWinEnter * setlocal foldmethod=manual
" Modify from pseewald/vim-anyfold and http://dhruvasagar.com/2013/03/28/vim-better-foldtext
set foldtext=MinimalFoldText()
function! MinimalFoldText() abort
	let fs = v:foldstart
	while getline(fs) !~ '\w'
		let fs = nextnonblank(fs + 1)
	endwhile
	if fs > v:foldend
		let line = getline(v:foldstart)
	else
        let line = substitute(getline(fs), '\t', repeat(' ', &tabstop), 'g')
		let line = substitute(line, '\(^\s*\)', {m -> repeat('⋅', strlen(m[1]))}, 'g')
	endif

	let w = winwidth(0) - &foldcolumn - &number * &numberwidth
	let foldSize = 1 + v:foldend - v:foldstart
    let foldSizeStr = '| ' . printf("%7s", foldSize . ' ') . ' |⋅⋅'
	let lineCount = line("$")

    if w - strwidth(foldSizeStr.line) > 0
        let expansionString = repeat("⋅", w - strwidth(foldSizeStr.line))
        return line . expansionString . foldSizeStr
    else
        let expansionString = repeat("⋅", w - strwidth(line))
        return line . expansionString
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  mapping                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick reload .vimrc
map <leader>ss :source $MYVIMRC<CR>

" tagbar
map <silent> <F6> :TagbarToggle<cr>
let g:tagbar_sort = 0

" toggle highlight search
noremap <F8> :set hlsearch! hlsearch?<CR>

" toogle paste mode
noremap <F4> :set paste! paste?<CR>

" folding
nmap <silent> <leader>izf vi}zf%<CR>
nmap <silent> <leader>zf va}zf%<CR>

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

map <silent> <right> :call BufferOrTabNext()<CR>
map <silent> <left> :call BufferOrTabPre()<CR>

" move page
map <UP> <C-E>
map <DOWN> <C-Y>

" Manually fix escape sequences as alt key handling in vim
" http://vim.wikia.com/wiki/Fix_meta-keys_that_break_out_of_Insert_mode
" execute "set <A-j>=\ej"
" execute "set <A-k>=\ek"

" multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" copy/paste
" map <leader>p "0p
" map <leader>P "0P
vnoremap <leader>y  "+y
nnoremap <leader>Y  "+yg_
nnoremap <leader>y  "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P


" cd to current file's directory
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
" cmap w!! w !sudo tee > /dev/null %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  vim-plug                                    "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" automatic installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'scrooloose/nerdcommenter'
Plug 'Isaac0616/vim-colors-solarized'
" Plug 'w0rp/ale'
Plug 'kshenoy/vim-signature'
Plug 'mbbill/undotree'
Plug 'scrooloose/nerdtree'
Plug 'Lokaltog/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/mru.vim'
Plug 'vim-scripts/YankRing.vim'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/restore_view.vim'
Plug 'vim-scripts/Mark--Karkat' | Plug 'bronson/vim-visual-star-search'
Plug 'yuttie/comfortable-motion.vim'
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
Plug 'matze/vim-move'
Plug 'Valloric/ListToggle'
Plug 'christoomey/vim-tmux-navigator'
" Plug 'jsfaint/gen_tags.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ntpeters/vim-better-whitespace'

Plug '$HOMEBREW_PREFIX/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'leafgarland/typescript-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug '~/src/pyxl/vim'
Plug 'Vimjas/vim-python-pep8-indent'
" Plug 'benmills/vimux'
Plug 'google/vim-searchindex'
" Plug 'ap/vim-buftabline'

" LSP related plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
" Plug 'zchee/deoplete-jedi'
" Plug 'zchee/deoplete-clang'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern'  }
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'davidhalter/jedi-vim'

" function! BuildYCM(info)
  " " info is a dictionary with 3 fields
  " " - name:   name of the plugin
  " " - status: 'installed', 'updated', or 'unchanged'
  " " - force:  set on PlugInstall! or PlugUpdate!
  " if a:info.status == 'installed' || a:info.force
    " !./install.py --clang-completer --js-completer
  " endif
" endfunction

" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }

" Plug 'terryma/vim-multiple-cursors'
" Plug 'Yggdroot/indentLine'
" Plug 'ronakg/quickr-preview.vim'
" Plug 'hari-rangarajan/CCTree'
" Plug 'wesleyche/SrcExpl'
" Plug 'abudden/taghighlight-automirror'
" Plug 'xolox/vim-misc' | Plug 'xolox/vim-easytags'
" Plug 'haya14busa/incsearch.vim'
" Plug 'tpope/vim-fugitive'

" Plug 'edkolev/tmuxline.vim'

Plug 'github/copilot.vim'

Plug 'windwp/nvim-autopairs'

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
hi Folded cterm=Bold

" airline
" command: :AirlineToggleWhitespace
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#close_symbol = ''
let airline#extensions#tabline#disable_refresh = 1
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
" set tags=./tags;
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

" YankRing
nnoremap <silent> <F10> :YRShow<CR>
let g:yankring_history_dir = '~/.local/share/nvim'

" NERD Commenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" use // for c language
let g:NERDAltDelims_c = 1
" use '#' instead of '# ' for python
let g:NERDAltDelims_python = 1

" MRU
let MRU_File = $HOME . '/.local/share/nvim/vim_mru_files'

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

nnoremap <F3> :Ack! <cword> %<CR>

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
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'
let g:ale_python_autoflake_options = '--remove-all-unused-imports'
let g:ale_python_isort_options = '--settings-path ~/.dotfiles/.isort.cfg'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
" let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = {
\   'python': ['flake8'],
\   'javascript': ['eslint'],
\   'json': ['jsonlint'],
\}

let g:ale_fixers = {
\   'python': ['autoflake', 'black', 'isort'],
\   'json': ['fixjson'],
\}

nmap <silent> <leader>aj <Plug>(ale_next_wrap)
nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
nmap <silent> <leader>af <Plug>(ale_fix)

" coc
let g:coc_global_extensions = ['coc-pyright', 'coc-json', 'coc-solargraph']
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" Copied from https://github.com/neoclide/coc.nvim/issues/1054
function! s:goto_tag(tagkind) abort
  let tagname = expand('<cWORD>')
  let winnr = winnr()
  let pos = getcurpos()
  let pos[0] = bufnr()

  if CocAction('jump' . a:tagkind)
    call settagstack(winnr, {
      \ 'curidx': gettagstack()['curidx'],
      \ 'items': [{'tagname': tagname, 'from': pos}]
      \ }, 't')
  endif
endfunction
nmap <silent> gd :call <SID>goto_tag("Definition")<CR>
nmap <silent> gi :call <SID>goto_tag("Implementation")<CR>
nmap <silent> gr :call <SID>goto_tag("References")<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
" inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm()
                              " \: "\<c-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call Format()
noremap <silent> <Leader>f :call Format()<cr>

function! Format()
    if &filetype == 'python'
        :silent !autoflake --remove-all-unused-imports -i %
        :edit!
    endif
    :silent call CocAction('format')
    :silent call CocAction('organizeImport')
endfunction

hi CocUnusedHighlight cterm=underline ctermfg=10
hi CocHintSign ctermfg=11

" " YouCompleteMe
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_show_diagnostics_ui = 0
" let g:ycm_complete_in_comments = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1
" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_max_num_candidates = 20
" let g:ycm_semantic_triggers = {
" \ 'c,cpp,python,javascript': [ 're!\w{2}' ]
" \}

" vim-indent-guides
nmap <silent> <Leader>ig :IndentGuidesToggle<CR>
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2

" jedi-vim
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = "0"
" let g:jedi#use_tabs_not_buffers = 1

" NERDTree
let NERDTreeShowHidden = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vim-better-whitespace
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitelines_at_eof=1
let g:strip_whitespace_confirm=0

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" if has('macunix')
    " let g:deoplete#sources#clang#libclang_path = '/usr/local/opt/llvm/lib/libclang.dylib'
    " let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/include/clang'
" elseif has('unix')
    " let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so'
    " let g:deoplete#sources#clang#clang_header = '/usr/local/opt/llvm/include/clang'
" endif

" testing
command! BufferDelete bp|bd #
cnoreabbrev bd BufferDelete
cnoreabbrev ,,s ~/src/server

" call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

let g:go_fmt_autosave = 0
let g:go_code_completion_enabled = 0

let g:fzf_layout = { 'down': '~30%' }

function! SGLink() range
    let revision = trim(system("git merge-base HEAD origin/master"))
    let git_root = trim(system("git rev-parse --show-toplevel"))
    let base = "https://sourcegraph.pp.dropbox.com/git.sjc.dropbox.com/server@" . revision . "/-/blob"
    let fname = substitute(expand("%:p"), git_root, "", "")
    let ln = "#L" . a:firstline
    if a:firstline != a:lastline
        let ln .= "-" . a:lastline
    end
    let @+ = base . fname . ln
endfunction
nnoremap <leader>sg :call SGLink()<cr>
vnoremap <leader>sg :call SGLink()<cr>

" auto-pairs
let g:AutoPairsMoveCharacter = ""

" copilot
imap <script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" nvim-autopairs
lua << EOF
local npairs = require("nvim-autopairs")
npairs.setup({
    fast_wrap = {},
})
EOF
