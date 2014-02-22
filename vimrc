"Features
set nocompatible
filetype off
filetype indent plugin on

"Must have options
syntax on
set hlsearch
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Usability options
set ignorecase
set smartcase
set backspace=eol,start,indent
set autoindent
set ruler
set laststatus=2
set confirm
set visualbell
set t_vb=
set cmdheight=1
set number
set pastetoggle=<F11>
set tabstop=2
set shiftwidth=2

"Visual options
set background=dark

"Bundles
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'ervandew/supertab'
Bundle 'flazz/vim-colorschemes'

"Ctrl-P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*.class

"NerdTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q
