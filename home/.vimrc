call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'arcticicestudio/nord-vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'yuezk/vim-js'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
call plug#end()

" colors
syntax on
set guifont=SpaceMonoNerdFontCompleteM-Regular:h15
set background=dark
colorscheme nord

" bindings
let mapleader=","

" leader bindings
nnoremap <leader>p :Files<CR>
nnoremap <leader>r :Rg<space>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
nnoremap <silent> <leader>v :e ~/.vimrc<CR>

" goto bindings
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
nmap <silent> <leader>f :ALEFix
nmap <silent> <leader>d :ALEGoToDefinition
nmap <silent> <leader>h :ALEHover

" split bindings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" fat finger bindings
:command W w
:command Wq wq
:command Qa qa
:command QA qa
:command WQ wq

" general
set hidden
set nocompatible
set runtimepath+=~/.vim
set clipboard=unnamed
set binary
set noeol
set modeline
set modelines=4
set cmdheight=1
set ttyfast
set lazyredraw
set ambiwidth=double
set noshowmode
set updatetime=300
set shortmess+=c

" backup and swap
set noswapfile
set nobackup
set nowritebackup


" formatting
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smartindent
set nojoinspaces

" search
set showmatch
set matchtime=5
set hlsearch
set ignorecase " ignore case when searching...
set smartcase " ...except when you're explicit with caps

" visual
set number
set relativenumber
set showtabline=2
set showcmd
set cursorline
set novisualbell
set noerrorbells
set conceallevel=0
set guioptions=

" plugins

" nerdtree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" fzf
" search for occurrences with ripgrep using <leader>r
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" fuzzy file search with preview <leader>p
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1


" deoplete
let g:deoplete#enable_at_startup = 1


" ale
let g:ale_linters = {
\   'javascript': ['eslint'],
\}
let g:ale_fixers = {
\   'javascript': ['eslint'],
\}
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '.'