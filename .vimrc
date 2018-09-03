call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
" Plug 'kien/ctrlp.vim'
Plug '/usr/local/opt/fzf'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'mileszs/ack.vim'
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-sensible'
Plug 'valloric/youcompleteme', { 'for': 'javascript' }
Plug 'w0rp/ale', { 'for': 'javascript' }
Plug 'Xuyuanp/nerdtree-git-plugin'
" themes
Plug 'jacoborus/tender.vim'
Plug 'Badacadabra/vim-archery'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'ajmwagar/vim-deus'
Plug 'yorickpeterse/happy_hacking.vim'
Plug 'rakr/vim-two-firewatch'
call plug#end()

" general
" =======
filetype plugin indent on
set nocompatible
set runtimepath+=~/.vim
set wildmenu
set wildignore=*.class,*.swp,*.swo
set history=256
set clipboard=unnamed " use the OS clipboard
set binary
set noeol
set autochdir
set modeline
set modelines=4
set lazyredraw
set ambiwidth=double

" folding
" =======
set foldenable
set foldmethod=syntax
set foldlevel=99
set foldopen-=search
set foldopen-=undo

" backup and swap
" =======
set noswapfile
set nobackup
set nowritebackup

" encoding
" =======
set encoding=UTF-8
set fileencodings=UTF-8

" formatting
" =======
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent

" theme
" =======
colorscheme tender
set guifont=CousineNerdFontCompleteM-Regular:h14

" visual
" =======
syntax on
set number
" set relativenumber " turned off because it causes very slow scrolling
set ruler
set showtabline=2
set showcmd
set novisualbell
set noerrorbells
set scrolloff=3
set laststatus=2
set conceallevel=0
set guioptions= " remove all scrollbars

" colors
" =======
" base16-shell keeps vim and shell consistent theme
" if filereadable(expand("~/.vimrc_background"))
"   let base16colorspace=256
"   source ~/.vimrc_background
" endif
" set t_Co=256
" if &term =~ '256color'
"   set t_ut=
" endif
" set background=dark
" if (has("termguicolors"))
"  set termguicolors
" endif

" search
" =======
set showmatch
set matchtime=5
set hlsearch " highlight matches...
set incsearch " ...dynamically while typing
set ignorecase " ignore case when searching...
set smartcase " ...except when you're explicit with caps

" grep
" =======
if executable('ag')
  set grepprg=ag\ --vimgrep
elseif executable('awk')
  set grepprg=ack\ -H\ --nocolor\ --nogroup
endif

set grepformat=%f:%l:%c:%m

" key mappings
" =======
let mapleader=","
let g:mapleader=","
set backspace=indent,eol,start
set mouse=a
set mousehide
nnoremap <silent> <Leader>/ :nohlsearch<CR>
nnoremap <C-p> :Files<cr>

" buffers
" =======
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <Tab><Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" split navigation
" =======
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" scrolling
" =======
nnoremap j gj
nnoremap k gk

" quickfix
map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>
nnoremap <leader>a :cclose<CR>

" startify config
" =======
let g:startify_bookmarks=[
      \ '~/.vimrc',
      \ '~/.zshrc',
      \ '~/dev/priviti/',
      \ '~/dev/fantastec/',
      \]

" lightline config
" =======
let g:lightline = {
\ 'colorscheme': 'wombat',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error',
\   'linter_ok': 'ok'
\ },
\ }
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ▲', all_non_errors)
endfunction
function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction
function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction
autocmd User ALELint call lightline#update()

" nerdtree config
" =======
map <leader>n :NERDTreeToggle<cr>
map <leader>l :NERDTreeFind<cr>
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize=60
" open nerdtree if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if only nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ctrlp config
" =======
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" let g:ctrlp_use_caching = 0

" editorconfig config
" =======
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" youcompleteme config
" =======
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" delimitmate config
" =======
let g:delimitMate_expand_cr = 1


" ale config
" =======
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
nmap <silent> <C-a> <Plug>(ale_next_wrap)

" ack config
" =======
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
