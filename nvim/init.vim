scriptencoding utf-8

call plug#begin('~/.vim/plugged')
  " Plug 'Raimondi/delimitMate'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'ruanyl/vim-gh-line'

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'tmux-plugins/vim-tmux-focus-events'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'

  if has('nvim')
    Plug 'hoob3rt/lualine.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'
    Plug 'glepnir/lspsaga.nvim'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'hrsh7th/vim-vsnip'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'shaunsingh/nord.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    Plug 'onsails/lspkind-nvim'
    Plug 'windwp/nvim-autopairs'
    Plug 'kabouzeid/nvim-lspinstall'
  endif
call plug#end()

" setup
lua << EOF
require('plugins')
require('settings')
-- require('keymappings')
require('lsp')
EOF


" bindings
let mapleader=","


inoremap <silent><expr> <CR>      compe#confirm('<CR>')


" leader bindings
nnoremap <silent> <leader>/ :noh<cr>
nnoremap <silent> <leader>b <cmd>lua require('plugins.config.telescope').buffers()<CR>
nnoremap <silent> <leader>c <cmd>lua require('plugins.config.telescope').commits()<CR>
nnoremap <silent> <leader>d :bd<CR>
nnoremap <silent> <leader>f :NvimTreeFindFile<CR>
nnoremap <silent> <leader>g <cmd>lua require('plugins.config.telescope').git_files()<CR>
nnoremap <silent> <leader>j <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <leader>k <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> <leader>l :NvimTreeToggle<CR>
nnoremap <silent> <leader>m :Git<CR>
nnoremap <silent> <leader>p <cmd>lua require('plugins.config.telescope').find_files()<CR>
nnoremap <silent> <leader>q <cmd>lua require('plugins.config.telescope').quickfix()<CR>
nnoremap <silent> <leader>r <cmd>lua require('plugins.config.telescope').live_grep()<CR>
nnoremap <silent> <leader>v <cmd>lua require('plugins.config.telescope').find_config_files()<CR>
nnoremap <silent> <leader>z <cmd>lua require('plugins.config.telescope').colorscheme()<CR>

" goto bindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gh <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gn <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> gp <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>

" codeaction bindings
nnoremap <silent> ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> cr <cmd>lua require('lspsaga.rename').rename()<CR>

" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)

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
