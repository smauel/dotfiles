call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'airblade/vim-gitgutter'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-sensible'
Plug 'valloric/youcompleteme', { 'for': 'javascript', 'on': [] }
Plug 'w0rp/ale'
call plug#end()

" lazy-load youcompleteme for faster startup times
augroup load_ycm
  autocmd!
  autocmd CursorHold, CursorHoldI * call plug#load('YouCompleteMe')
                                \ | autocmd! load_ycm
augroup END

" general
filetype plugin indent on
set nocompatible
set runtimepath+=~/.vim
set wildmenu
set history=256
set clipboard=unnamed
set binary
set noeol
set modeline
set modelines=4
set lazyredraw
set ambiwidth=double
set noshowmode                                          " handled by lightline

" backup/swap
set noswapfile
set nobackup
set nowritebackup

" encoding
set encoding=UTF-8
set fileencodings=UTF-8

" formatting
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent
set formatoptions+=j                                    " swallow comment when joining lines of comments
set nojoinspaces                                        " don't insert space when joing lines

" visual
syntax on
set number
set relativenumber
set ruler
set showtabline=2
set showcmd
set cursorline
set novisualbell
set noerrorbells
set laststatus=2
set conceallevel=0
set guioptions=
set background=dark
set termguicolors
colorscheme onedark
set guifont=HackNerdFontComplete-Regular:h14

" search
set showmatch
set matchtime=5
set hlsearch
set incsearch
set ignorecase
set smartcase

" key mappings
let mapleader=","
set backspace=indent,eol,start
set mouse=a
set mousehide
nnoremap <C-p> :Files<CR>
" clear search highlights
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" write silently
nnoremap <silent> <Leader>w :silent w<CR>
" switch to previous buffer
nnoremap <Leader><Leader> <C-^>
" close all but the current buffer
nnoremap <Leader>o :only<CR>

" buffers
nnoremap <tab><tab> :bn<CR>
nnoremap <S-tab> :bp<CR>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-k> <C-w><C-k>

" splits
set splitbelow
set splitright

" scrolling
set scrolloff=3
nnoremap j gj
nnoremap k gk

" visual move
xnoremap <silent> K :call MoveUp()<CR>
xnoremap <silent> J :call MoveDown()<CR>
function! MoveUp() abort range
  let l:at_top=a:firstline == 1
  call s:Move("'<-2", l:at_top)
endfunction
function! MoveDown() abort range
  let l:at_bottom=a:lastline == line('$')
  call s:Move("'>+1", l:at_bottom)
endfunction
function! s:Move(address, at_limit)
  if s:Visual() && !a:at_limit
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction
function! s:Visual()
  return visualmode() == 'V'
endfunction

" ale
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ }
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \ }
let g:ale_fix_on_save = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'onedark',
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

" nerdtree
map <Leader>n :NERDTreeToggle<cr>
map <Leader>l :NERDTreeFind<cr>
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize=40
let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " close vim if only nerdtree

" youcompleteme
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" delimitmate
let delimitMate_expand_cr = 1