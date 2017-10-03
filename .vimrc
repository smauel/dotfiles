call plug#begin('~/.vim/plugged')
Plug 'chriskempson/base16-vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-git'
Plug 'tpope/vim-sensible'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'sheerun/vim-polyglot'
Plug 'valloric/youcompleteme', { 'for': 'javascript' }
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
Plug 'w0rp/ale', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
call plug#end()

" base16-shell keeps vim and shell consistent theme
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" general
filetype plugin indent on
syntax enable
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
set encoding=utf-8
set fileencodings=utf-8

" formatting
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent

" theme
colorscheme base16-default-dark
set guifont=Knack\ Regular\ Nerd\ Font\ Complete\ Mono:h14

" visual
syntax on
set number
set relativenumber
set ruler
set showtabline=2
set showcmd
set novisualbell
set noerrorbells
set scrolloff=3
set laststatus=2
set conceallevel=0

" colors
set t_Co=256
if &term =~ '256color'
  set t_ut=
endif
set background=dark

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
let g:mapleader=","
set backspace=indent,eol,start
set mouse=a
set mousehide
nnoremap <silent> <Leader>/ :nohlsearch<CR>

" buffers
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <Tab><Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" startify config
let g:startify_bookmarks=[
      \ '~/.vimrc',
      \ '~/.zshrc',
      \]

" airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16'

" nerdtree config
map <leader>n :NERDTreeToggle<cr>
map <leader>l :NERDTreeFind<cr>
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
let NERDTreeAutoDeleteBuffer = 1
"close vim if only nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ctrlp config
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" editorconfig config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" youcompleteme config
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" delimitmate config
let g:delimitMate_expand_cr = 1


" ale config
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_fixers = { 'javascript': ['eslint'] }
let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" jsformat
"" esformatter (npm install -g esformatter)
nnoremap <silent> <leader>e :call JSFormat()<cr>
function! JSFormat()
  " Preparation: save last search, and cursor position.
  let l:win_view = winsaveview()
  let l:last_search = getreg('/')
  let fileWorkingDirectory = expand('%:p:h')
  let currentWorkingDirectory = getcwd()
  execute ':lcd' . fileWorkingDirectory
  execute ':silent' . '%!esformatter'
  if v:shell_error
    undo
    "echo "esformatter error, using builtin vim formatter"
    " use internal formatting command
    execute ":silent normal! gg=G<cr>"
  endif
  " Clean up: restore previous search history, and cursor position
  execute ':lcd' . currentWorkingDirectory
  call winrestview(l:win_view)
  call setreg('/', l:last_search)
endfunction