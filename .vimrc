call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
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
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
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
syntax on
set nocompatible
set runtimepath+=~/.vim
set wildmenu
set history=256
set clipboard=unnamed
set binary
set noeol
set modeline
set modelines=4
set ttyfast
set lazyredraw
set ambiwidth=double
set noshowmode                                          " handled by lightline

" folding
set foldenable
set foldmethod=syntax
set foldlevel=99
set foldopen-=search
set foldopen-=undo

" backup and swap
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

" theme
if (has("termguicolors"))
  set termguicolors
endif
colorscheme onedark
set guifont=SauceCodeProNerdFontCompleteM-Regular:h13
highlight Visual guibg=Green guifg=Black

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

" search
set showmatch
set matchtime=5
set hlsearch " highlight matches...
set incsearch " ...dynamically while typing
set ignorecase " ignore case when searching...
set smartcase " ...except when you're explicit with caps

" grep
if executable('ag')
  set grepprg=ag\ --vimgrep
elseif executable('awk')
  set grepprg=ack\ -H\ --nocolor\ --nogroup
endif

set grepformat=%f:%l:%c:%m

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

" splits
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <Tab><Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
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
nmap <silent> <C-a> <Plug>(ale_next_wrap)

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
map <leader>n :NERDTreeFind<cr>
map <leader>l :NERDTreeToggle<cr>
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize=40
let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " close vim if only nerdtree

" editorconfig config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" youcompleteme config
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" delimitmate
let delimitMate_expand_cr = 1

" ale config
"let g:ale_linters = { 'javascript': ['eslint'] }
"let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
nmap <silent> <C-a> <Plug>(ale_next_wrap)

" ack config
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim test
nmap <silent> <C-t><C-n> :TestNearest<CR>
nmap <silent> <C-t><C-f> :TestFile<CR>

" fzf config
" search for occurrences with ripgrep using <leader>r
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <leader>r :Rg<space>

" search git commits with fzf
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <leader>c  :Commits<CR>