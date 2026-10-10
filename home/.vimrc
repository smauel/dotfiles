call plug#begin()
	Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
    Plug 'tpope/vim-fugitive'
	Plug 'tpope/vim-sensible'
    Plug '/usr/bin/fzf' 
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
call plug#end()

let mapleader=','
colorscheme retrobox

set autoindent
set background=dark
set backspace=eol,start,indent
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

set statusline=%{HasPaste()}\ %f%m%r%h\ %{FugitiveStatusline()}

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
command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

" fatfinger bindings
cmap qw wq
cmap Wq wq
cmap WQ wq
cmap wQ wq

" movement
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

map <leader>P :setlocal paste!<cr>
map <leader>l :NERDTreeToggle<cr>
map <leader>p :FZF!<cr>
map <leader>r :Rg!<cr>
map <leader>/ :nohlsearch<cr>
map <leader>gb :Git blame<cr>
map <leader>gd :Git diff<cr>

" move a line of text with alt-jk
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" is paste mode enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

