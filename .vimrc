call plug#begin('~/.vim/plugged')
Plug 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'airblade/vim-gitgutter'
Plug 'dracula/vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'kien/ctrlp.vim'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
Plug 'moll/vim-node', { 'for': 'javascript' }
Plug 'nathanaelkane/vim-indent-guides', { 'for': 'javascript' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
Plug 'scrooloose/syntastic', { 'for': 'javascript' }
Plug 'sidorares/node-vim-debugger', { 'for': 'javascript' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
Plug 'tpope/vim-surround', { 'for': 'javascript' }
Plug 'valloric/youcompleteme', { 'for': 'javascript' }
call plug#end()

" ==========
" GUI
" ==========
colorscheme dracula
set number
set hlsearch
if has('gui_running')
  set guifont=Knack\ Regular\ Nerd\ Font\ Complete:h14
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
" Syntastic
" ==========
let g:syntastic_check_on_open=1
let g:syntastic_javascript_checkers=['eslint']

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

" ==========
" CtrlP
" ==========
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" ==========
" DelimitMate
" ==========
let g:delimitMate_expand_cr = 1

" ==========
" esformatter (npm install -g esformatter)
" ==========
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

" ==========
" Codi
" ==========
nnoremap <Leader><Leader>c :Codi!!<CR>
xnoremap <Leader><Leader>c :Codi!!<CR>

" ==========
" Editor Config
" ==========
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ==========
" Vim Startify
" ==========
let g:startify_bookmarks=[
  \ '~/.vimrc',
  \ '~/.zshrc',
\]
