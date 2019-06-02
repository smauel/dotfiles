call plug#begin('~/.vim/plugged')
Plug '/usr/local/opt/fzf'
Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
Plug 'airblade/vim-gitgutter'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'mhinz/vim-signify'
Plug 'mxw/vim-jsx', { 'for': 'jsx' }
Plug 'pangloss/vim-javascript'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown', { 'do': 'npm install -g livedown' }
Plug 'ternjs/tern_for_vim', { 'for': 'javascript', 'do': 'npm install' }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'valloric/youcompleteme', { 'for': 'javascript', 'on': [] }
Plug 'whatyouhide/vim-gotham'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
call plug#end()

" lazy-load youcompleteme for faster startup times
augroup load_ycm
  autocmd!
  autocmd CursorHold, CursorHoldI * call plug#load('YouCompleteMe')
                                \ | autocmd! load_ycm
augroup END

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

" folding
set foldenable
set foldmethod=syntax
set foldlevel=99
set foldopen-=search
set foldopen-=undo

" backup and swap
set noswapfile
set nobackup
set nowritebackup

" encoding
set encoding=UTF-8
set fileencodings=UTF-8

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

" theme
if (has("termguicolors"))
  set termguicolors
endif
colorscheme onedark
set guifont=RobotoMonoNerdFontCompleteM-Medium:h12
highlight Visual guibg=Green guifg=Black

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
set termguicolors
set signcolumn=yes

" search
set showmatch
set matchtime=5
set hlsearch " highlight matches...
set incsearch " ...dynamically while typing
set ignorecase " ignore case when searching...
set smartcase " ...except when you're explicit with caps

" grep
if executable('ag')
  set grepprg=ag\ --vimgrep
elseif executable('awk')
  set grepprg=ack\ -H\ --nocolor\ --nogroup
endif

set grepformat=%f:%l:%c:%m

" key mappings
let mapleader=","
set backspace=indent,eol,start
set mouse=a
set mousehide
nnoremap <C-p> :Files<CR>
" clear search highlights
nnoremap <silent> <Leader>/ :nohlsearch<CR>
" write silently
nnoremap <silent> <Leader>w :silent w<CR>
" switch to previous buffer
nnoremap <Leader><Leader> <C-^>
" close all but the current buffer
nnoremap <Leader>o :only<CR>

" splits
nnoremap <silent> <Leader>bd :bd<CR>
nnoremap <Tab><Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>

" split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
set splitbelow
set splitright

" scrolling
set scrolloff=3
nnoremap j gj
nnoremap k gk

" visual move
xnoremap <silent> K :call MoveUp()<CR>
xnoremap <silent> J :call MoveDown()<CR>
function! MoveUp() abort range
  let l:at_top=a:firstline == 1
  call s:Move("'<-2", l:at_top)
endfunction
function! MoveDown() abort range
  let l:at_bottom=a:lastline == line('$')
  call s:Move("'>+1", l:at_bottom)
endfunction
function! s:Move(address, at_limit)
  if s:Visual() && !a:at_limit
    execute "'<,'>move " . a:address
    call feedkeys('gv=', 'n')
  endif
  call feedkeys('gv', 'n')
endfunction
function! s:Visual()
  return visualmode() == 'V'
endfunction

" coc
let g:coc_status_warning_sign = "\uf071"
let g:coc_status_error_sign = "\uf05e"

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

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

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" lightline
let g:lightline = {
      \ 'colorscheme': 'gotham',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['gitbranch', 'filename', 'modified']],
      \   'right': [['lineinfo'], ['percent'], ['cocstatus'], ['fileformat', 'fileencoding', 'filetype']]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" nerdtree
map <leader>n :NERDTreeFind<cr>
map <leader>l :NERDTreeToggle<cr>
let NERDTreeShowHidden = 1
let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeWinSize=40
let NERDTreeMinimalUI = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " close vim if only nerdtree

" editorconfig config
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" youcompleteme config
let g:ycm_add_preview_to_completeopt=0
let g:ycm_confirm_extra_conf=0
set completeopt-=preview

" delimitmate
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1

" ale config
nmap <silent> <C-a> <Plug>(ale_next_wrap)

" ack config
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim test
nmap <silent> <C-t><C-n> :TestNearest<CR>
nmap <silent> <C-t><C-f> :TestFile<CR>

" fzf config
" search for occurrences with ripgrep using <leader>r
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nmap <leader>r :Rg<space>

" search git commits with fzf
let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
nnoremap <silent> <leader>c  :Commits<CR>