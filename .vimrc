call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-fugitive'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'editorconfig/editorconfig-vim'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
call plug#end()

" general
filetype plugin indent on
syntax on
set hidden
set nocompatible
set runtimepath+=~/.vim
set wildmenu
set history=256
set clipboard=unnamed
set binary
set noeol
set modeline
set modelines=4
set cmdheight=2
set ttyfast
set lazyredraw
set ambiwidth=double
set noshowmode                                          " handled by lightline
set updatetime=300
set shortmess+=c

" backup and swap
set noswapfile
set nobackup
set nowritebackup

" encoding
set encoding=UTF-8
set fileencodings=UTF-8

" bindings
let mapleader=","
nnoremap <c-p> :Files<CR>
nnoremap <silent> <leader>/ :nohlsearch<CR>
" fat finger bindings
:command W w
:command Qa qa
:command WQ wq

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

" colors
set guifont=SpaceMonoNerdFontCompleteM-Regular:h15
set background=dark
colorscheme gruvbox

" search
set showmatch
set matchtime=5
set hlsearch " highlight matches...
set incsearch " ...dynamically while typing
set ignorecase " ignore case when searching...
set smartcase " ...except when you're explicit with caps

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
set signcolumn=yes

""""""""""
" plugins
"""""""""""
" nerdtree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
map <Leader>l : NERDTreeToggle<CR>
nnoremap <silent> <Leader>f :NERDTreeFind<CR>
" autocmd VimEnter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" fzf
" search for occurrences with ripgrep using <leader>r
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <leader>r :Rg<space>

" search git commits with fzf
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
nnoremap <silent> <leader>c  :Commits<CR>
nnoremap <silent> <leader>bc  :BCommits<CR>


" coc
" use tab for completion
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" c-space to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for code action
nmap <leader>a :CocAction<CR>

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}