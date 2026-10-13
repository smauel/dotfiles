call plug#begin()
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
	Plug 'tpope/vim-sensible'
    Plug '/usr/bin/fzf' 
    Plug 'Raimondi/delimitMate'
    Plug 'airblade/vim-gitgutter'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'rhysd/vim-clang-format'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
call plug#end()

let mapleader=','
colorscheme retrobox

set autoindent
set background=dark
set backspace=eol,start,indent
set clipboard=unnamedplus
set encoding=utf8
set expandtab
set foldcolumn=1
set history=500
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set magic
set matchtime=2
set nobackup
set noerrorbells
set noswapfile
set novisualbell
set nowritebackup
set number
set regexpengine=0
set relativenumber
set ruler
set scrolloff=7
set shiftwidth=4
set showmatch
set smartcase
set smartindent
set t_vb=
set tabstop=4
set timeoutlen=500
set whichwrap+=<,>,h,l
set wildignore+=*/.git/*
set wildmenu
set wrap

syntax enable

" enable filetype plugins
filetype plugin on
filetype indent on

" auto read file changes from the outside
set autoread
au FocusGained,BufEnter * silent! checktime

" return to last edit position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" sudo save
command! WW execute 'w !sudo tee % > /dev/null' <bar> edit!

" fatfinger bindings: only expand when the whole : command is the typo
cnoreabbrev <expr> W  getcmdtype() == ':' && getcmdline() ==# 'W'  ? 'w'  : 'W'
cnoreabbrev <expr> Wq getcmdtype() == ':' && getcmdline() ==# 'Wq' ? 'wq' : 'Wq'
cnoreabbrev <expr> WQ getcmdtype() == ':' && getcmdline() ==# 'WQ' ? 'wq' : 'WQ'
cnoreabbrev <expr> wQ getcmdtype() == ':' && getcmdline() ==# 'wQ' ? 'wq' : 'wQ'
cnoreabbrev <expr> qw getcmdtype() == ':' && getcmdline() ==# 'qw' ? 'wq' : 'qw'

" movement
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

nnoremap <leader>P :setlocal paste!<cr>
nnoremap <leader>l :NERDTreeToggle<cr>
nnoremap <leader>p :GFiles!<cr>
nnoremap <leader>r :Rg!<cr>
nnoremap <leader>/ :nohlsearch<cr>
nnoremap <leader>bd :bd<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gd :Git diff<cr>
nnoremap <leader>gh :GBrowse<cr>
nmap <leader>gn <Plug>(GitGutterNextHunk)
nmap <leader>gp <Plug>(GitGutterPrevHunk)

" move a line of text with alt-jk
nnoremap <M-j> mz:m+<cr>`z
nnoremap <M-k> mz:m-2<cr>`z
vnoremap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vnoremap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" is paste mode enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" let g:github_enterprise_urls = ['https://example.com']
let NERDTreeShowHidden=1

" format on save
let g:clang_format#auto_format=1
