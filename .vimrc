" ----------------------------------------
"  options
" ----------------------------------------
let mapleader = ","
let loaded_matchparen=1

syntax on

" display options
set cmdheight=1                  " number of lines for command-line height
set expandtab                    " use soft indent
set laststatus=2                 " show status bar always
set lcs=tab:>.,trail:_,extends:+ " show special items
set list
set number
set tabstop=4                    " tab means 4 spaces
set shiftwidth=4                 " indent 4 spaces
set softtabstop=0                " when pressed tab key, provides indent same as 'tabstop'
set wrap

" edit options
set autoindent
set backspace=indent,eol,start
set formatoptions-=o             " not insert comment prefix characters by o/O
set smartindent                  " smart indent on new line
set smarttab                     " at the beggining of line, expanded tab smart operation
set nrformats=                   " increment as decimal
set hidden                       " not close, keep undo history
set showmatch                    " hilight
set matchtime=3                  " hilight 3sec

" search behavior
set hlsearch
set ignorecase
set incsearch
set smartcase                    " override 'ignorecase' on search with upper case character
set wrapscan                     " Searches wrap around the end of the file

" completion
set completeopt=menuone,preview

" command-line completion
set wildmenu                     " enhanced command-line completion
set wildmode=list:full           " When more than one match, list all matches and complete first match.

" file operation
set autoread                     " reload file when detect changed at other process
set nobackup
set noswapfile
set fileencodings=utf-8,iso-2022-jp,cp932,eucjp-ms

" beep
set visualbell

" highlight JpSpace
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
autocmd BufRead,BufNew * match JpSpace /　/

" statusline
set statusline=%y%{GetStatusEx()}%F%m%r%=<%c:%l>
highlight StatusLine term=NONE cterm=NONE ctermfg=black ctermbg=cyan
function! GetStatusEx()
    let str = &fileformat . ']'
    if has('multi_byte') && &fileencoding != ''
    let str = '[' . &fileencoding . ':' . str
    endif
    return str
endfunction

"" automatical move current directory
"augroup BufferAu
"    autocmd!
"    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
"augroup END

" popup menu color schema
highlight Pmenu ctermbg=lightcyan ctermfg=black
highlight PmenuSel ctermbg=blue ctermfg=black
highlight PmenuSbar ctermbg=darkgray
highlight PmenuThumb ctermbg=lightgray


" ----------------------------------------
"  NeoBundle
" ----------------------------------------
set nocompatible
filetype plugin indent off

if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundle 'Shougo/neobundle.vim'
NeoBundle "nvie/vim-flake8"
NeoBundle 'vim-scripts/YankRing.vim'
"NeoBundle 'thinca/vim-quickrun'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neomru.vim'
"NeoBundle 'Shougo/vimfiler'
"NeoBundle 'majutsushi/tagbar'
NeoBundle "Align"
"NeoBundle 'kana/vim-smartchr'
"NeoBundle 'ekalinin/Dockerfile.vim'
"NeoBundle 'glidenote/keepalived-syntax.vim'
"NeoBundle 'Blackrush/vim-gocode'

let g:make = 'gmake'
if system('uname -o') =~ '^GNU/'
        let g:make = 'make'
endif

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

filetype plugin indent on


" ----------------------------------------
"  global key maps
" ----------------------------------------

" tab navigation
nnoremap <tab> :tabn<CR>
nnoremap <S-tab> :tabp<CR>
nnoremap <C-t> :tabnew<CR>

" cursor
nnoremap j gj
nnoremap k gk
inoremap <C-b> <Left>
inoremap <C-f> <Right>

" toggle mode
nnoremap <Space>n :<C-u>setlocal number! \| setlocal number?<CR>
nnoremap <Space>p :<C-u>setlocal paste! \| setlocal paste?<CR>
nnoremap <Space>w :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>e :<C-u>setlocal expandtab! \| setlocal expandtab?<CR>

" completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" visual
vnoremap < <gv
vnoremap > >gv

" etc
nnoremap <Leader><Leader> :<C-u>up<CR>
nnoremap <C-h> :help 
nnoremap <silent> <Esc><Esc> :nohlsearch<CR>
nnoremap <Space>o :<C-u>only<CR>

" http://whileimautomaton.net/2008/08/vimworkshop3-kana-presentation
"nnoremap <Space>ow :<C-u>setlocal wrap! \| setlocal wrap?<CR>
nnoremap <Space>.  :<C-u>edit $MYVIMRC<CR>
nnoremap <Space>s. :<C-u>source $MYVIMRC<CR>
nnoremap <Space>m  :<C-u>marks<CR>
nnoremap <Space>r  :<C-u>registers<CR>
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '/' ? '\?' : '?'

" git
nnoremap <F2> :!git diff %<CR>
nnoremap <F6> :!git blame %<CR>
nnoremap <F8> :!git log -p %<CR>

" ----------------------------------------
"  file types
" ----------------------------------------
augroup MyFileTypes
    autocmd!
    autocmd BufNewFile,BufRead *.cfg  setlocal filetype=nagios
    autocmd BufNewFile,BufRead *.pp   setlocal filetype=puppet
    autocmd BufNewFile,BufRead *.sql  setlocal filetype=mysql
    autocmd BufNewFile,BufRead *.less setlocal filetype=css
    autocmd BufNewFile,BufRead *.html setlocal filetype=xhtml  " if file type is html, omni complete as upper case
    autocmd BufNewFile,BufRead keepalived.conf setlocal filetype=keepalived
augroup END

augroup DefineOmniFuncs
    autocmd!
    autocmd FileType c          setlocal omnifunc=ccomplete#Complete
    autocmd FileType css        setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html       setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType php        setlocal omnifunc=phpcomplete#CompletePHP
    autocmd FileType python     setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType ruby       setlocal omnifunc=rubycomplete#Complete
    autocmd FileType sql        setlocal omnifunc=sqlcomplete#Complete
    autocmd FileType xml        setlocal omnifunc=xmlcomplete#CompleteTags
    " default omnifunc.
    autocmd Filetype * if &l:omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
augroup END

" ----------------------------------------
"  plugin settings
" ----------------------------------------

" if has('lua') && v:version > 703 && has('patch825') 2013-07-03 14:30 > から >= に修正
" if has('lua') && v:version >= 703 && has('patch825') 2013-07-08 10:00 必要バージョンが885にアップデートされていました
if has('lua') && v:version >= 703 && has('patch885')
    NeoBundleLazy "Shougo/neocomplete.vim", {
        \ "autoload": {
        \   "insert": 1,
        \ }}
    " 2013-07-03 14:30 NeoComplCacheに合わせた
    let g:neocomplete#enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplete.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplet#enable_smart_case = 1
        " NeoCompleteを有効化
        " NeoCompleteEnable
    endfunction
else
    NeoBundleLazy "Shougo/neocomplcache.vim", {
        \ "autoload": {
        \   "insert": 1,
        \ }}
    " 2013-07-03 14:30 原因不明だがNeoComplCacheEnableコマンドが見つからないので変更
    let g:neocomplcache_enable_at_startup = 1
    let s:hooks = neobundle#get_hooks("neocomplcache.vim")
    function! s:hooks.on_source(bundle)
        let g:acp_enableAtStartup = 0
        let g:neocomplcache_enable_smart_case = 1
        " NeoComplCacheを有効化
        " NeoComplCacheEnable_
    endfunction
endif

" - neocomplcache ------------------------

" Use neocomplcache.
let g:NeoComplCache_EnableAtStartup = 1
" Use smartcase.
let g:NeoComplCache_SmartCase = 1
" Use previous keyword completion.
let g:NeoComplCache_PreviousKeywordCompletion = 1
" Use tags auto update.
let g:NeoComplCache_TagsAutoUpdate = 1
" Use preview window.
let g:NeoComplCache_EnableInfo = 1
" Use camel case completion.
let g:NeoComplCache_EnableCamelCaseCompletion = 1
" Use underbar completion.
let g:NeoComplCache_EnableUnderbarCompletion = 1
" Set minimum syntax keyword length.
let g:NeoComplCache_MinSyntaxLength = 2
" Set skip input time.
let g:NeoComplCache_SkipInputTime = '0.2'
" Set manual completion length.
let g:NeoComplCache_ManualCompletionStartLength = 0

" - Align --------------------------------
vnoremap a :Align
vnoremap A :Align => <CR>

" - tagbar -------------------------------
let g:tagbar_left = 1
nnoremap <Space>t :TagbarToggle<CR>
nnoremap <C-w>h <C-w>h :let g:tagbar_left=1<CR>
nnoremap <C-w>l <C-w>l :let g:tagbar_left=0<CR>

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" - vimfiler -----------------------------
nnoremap <Space>f  :VimFiler<CR>
nnoremap <Space>F  :VimFilerExplorer<CR>
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_ignore_pattern = '\.pyc$'
let g:vimfiler_safe_mode_by_default = 0

" - unite.vim ----------------------------
"let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

nnoremap <silent> <Space>ub :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>uf :<C-u>Unite file<CR>
nnoremap <silent> <Space>uu :<C-u>Unite file_mru buffer<CR>

nnoremap <silent> <Space>ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <Space>ur  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" ----------------------------------------
"  Python
" ----------------------------------------

" - flake8 -------------------------------
augroup Hooks
    autocmd BufWrite *.py :call Flake8()
augroup END
