scriptencoding utf-8

call plug#begin('~/.vim/plugged')
  Plug 'MaxMEllon/vim-jsx-pretty'
  Plug 'Raimondi/delimitMate'
  Plug 'airblade/vim-gitgutter'
  Plug 'arcticicestudio/nord-vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'leafgarland/typescript-vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ruanyl/vim-gh-line'
  Plug 'sainnhe/gruvbox-material'
  Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-surround'
  Plug 'yuezk/vim-js'

  if has('nvim')
    Plug 'hoob3rt/lualine.nvim'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
  endif
call plug#end()


" bindings
let mapleader=","


" leader bindings
nnoremap <leader>p <cmd>lua require('plugins.config.telescope').find_files()<CR>
nnoremap <leader>r <cmd>lua require('plugins.config.telescope').live_grep()<CR>
nnoremap <leader>b <cmd>lua require('plugins.config.telescope').buffers()<CR>
nnoremap <leader>c <cmd>lua require('plugins.config.telescope').commits()<CR>
nnoremap <leader>g <cmd>lua require('plugins.config.telescope').git_files()<CR>
nnoremap <leader>q <cmd>lua require('plugins.config.telescope').quickfix()<CR>
nnoremap <leader>a :CocAction<CR>
nnoremap <silent> <leader>d :bd<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>l :NERDTreeToggle<CR>
nnoremap <silent> <leader>m :Git<CR>
nnoremap <silent> <leader>v :e ~/.vimrc<CR>
nnoremap <silent> <leader>/ :noh<cr>
" nmap <leader>q <Plug>(coc-fix-current)
nnoremap <leader>jp :call  CocAction('runCommand', 'jest.projectTest')<CR>
nnoremap <leader>jc :call  CocAction('runCommand', 'jest.fileTest', ['%'])<CR>
nnoremap <leader>jt :call CocAction('runCommand', 'jest.singleTest')<CR>


" goto bindings
nmap <silent> gp <Plug>(coc-diagnostic-prev)
nmap <silent> gn <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gi <Plug>(coc-implementation)
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

" plugins

" nerdtree
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen=1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

lua << EOF
require('plugins')
require('settings')
EOF

