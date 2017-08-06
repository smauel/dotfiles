call plug#begin('~/.vim/plugged')
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'nathanaelkane/vim-indent-guides', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround', { 'for': 'javascript' }
Plug 'valloric/youcompleteme', { 'for': 'javascript' }
Plug 'jistr/vim-nerdtree-tabs'
call plug#end()

" ==========
" GUI
" ==========
colorscheme dracula
set number
set hlsearch
if has('gui_running')
  set guifont=Fira\ Mono:h18
endif

" ==========
" BEHAVIOUR
" ==========
let mapleader=","
set noswapfile
set nowritebackup
set nobackup

" ==========
" PLUGIN CONFIG
" ==========
"
" ==========
" NERDTree && NERDTreeTabs
" ==========
map <leader>n <plug>NERDTreeTabsToggle<CR>
map <leader>l :NERDTreeFind<cr>
let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=0
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=1
let g:nerdtree_tabs_open_on_console_startup=1
"close vim if only nerdtree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" ==========
" Sytastic
" ==========
let g:syntastic_check_on_open=1

" ==========
" YouCompleteMe
" ==========
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" ==========
" Vim-Indent-Guides
" ==========
set ts=2 sw=2 et
let g:indent_guides_enable_on_vim_startup = 1
