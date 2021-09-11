scriptencoding utf-8

call plug#begin('~/.config/nvim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ruanyl/vim-gh-line'

Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'christoomey/vim-tmux-navigator'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" nvim/lua plugins
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fannheyward/telescope-coc.nvim'
Plug 'windwp/nvim-autopairs'

" colorschemes
Plug 'shaunsingh/nord.nvim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
call plug#end()


" colors
syntax on
set guifont=SpaceMonoNerdFontCompleteM-Regular:h15
set termguicolors
set background=dark
let g:everforest_background='hard'
colorscheme everforest


" bindings
let mapleader=","


" leader bindings
nnoremap <silent> <leader>/ :noh<cr>
nnoremap <silent> <leader>b <cmd>lua require('plugins.config.telescope').buffers()<CR>
nnoremap <silent> <leader>c <cmd>lua require('plugins.config.telescope').commits()<CR>
nnoremap <silent> <leader>d :bd<CR>
nnoremap <silent> <leader>f :NvimTreeFindFile<CR>
nnoremap <silent> <leader>g <cmd>lua require('plugins.config.telescope').git_files()<CR>
nnoremap <silent> <leader>l :NvimTreeToggle<CR>
nnoremap <silent> <leader>m :Git<CR>
nnoremap <silent> <leader>p <cmd>lua require('plugins.config.telescope').find_files()<CR>
nnoremap <silent> <leader>q <cmd>lua require('plugins.config.telescope').quickfix()<CR>
nnoremap <silent> <leader>r <cmd>lua require('plugins.config.telescope').live_grep()<CR>
nnoremap <silent> <leader>v <cmd>lua require('plugins.config.telescope').find_config_files()<CR>
nnoremap <silent> <leader>z <cmd>lua require('plugins.config.telescope').colorscheme()<CR>
nnoremap <silent> <leader>jp :call  CocAction('runCommand', 'jest.projectTest')<CR>
nnoremap <silent> <leader>jc :call  CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
nnoremap <silent> <leader>jt :call CocAction('runCommand', 'jest.singleTest')<CR>


" goto bindings
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" coclist bindings
nnoremap <silent> <space>a  :<C-u>Telescope coc file_code_actions<cr>
nnoremap <silent> <space>c  :<C-u>Telescope coc commands<cr>
nnoremap <silent> <space>d  :<C-u>Telescope coc definitions<cr>
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>


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


" move lines up and down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


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
set signcolumn=number

" plugins

" nvimtree
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_gitignore = 1


" coc
let g:coc_global_extensions = [ 'coc-actions', 'coc-css', 'coc-eslint', 'coc-git', 'coc-gitignore', 'coc-highlight', 'coc-html', 'coc-java', 'coc-jest', 'coc-json', 'coc-markdownlint', 'coc-metals', 'coc-prettier', 'coc-python', 'coc-react-refactor', 'coc-sh', 'coc-snippets', 'coc-sumneko-lua', 'coc-tsserver', 'coc-yaml' ]

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

" lua plugins
lua <<EOF
require('plugins')
EOF