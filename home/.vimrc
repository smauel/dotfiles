scriptencoding utf-8

call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/gruvbox-material'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yuezk/vim-js'
call plug#end()


" colors
syntax on
set guifont=SpaceMonoNerdFontCompleteM-Regular:h15
set background=dark
colorscheme gruvbox-material
hi CursorLine cterm=NONE ctermbg=black


" bindings
let mapleader=","


" leader bindings
nnoremap <leader>p :Files<CR>
nnoremap <leader>r :Rg<space>
nnoremap <leader>a :CocAction<CR>
nnoremap <silent> <leader>bd :bd<CR>
nnoremap <silent> <leader>c :Commits<CR>
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
nnoremap <silent> <leader>v :e ~/.vimrc<CR>
nnoremap <silent> <leader>/ :noh<cr>
nmap <leader>q <Plug>(coc-fix-current)


" goto bindings
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)


" coclist bindings
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>


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


" handle wrapped lines nicely
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')


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
set noshowmode
set updatetime=300
set shortmess+=c
set scrolloff=3
set encoding=utf-8

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
set smarttab
set nojoinspaces
set autoindent
set formatoptions+=j


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
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" fuzzy file search with preview <leader>p
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)


" airline
let g:airline_powerline_fonts = 1
let g:airline_theme='minimalist'


" coc
" use tab for trigger completion, completion confirm and snippet expand
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use tab for snippet jump
let g:coc_snippet_next = '<tab>'

" K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction