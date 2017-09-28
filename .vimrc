"" general {{{
  set nocompatible
  set runtimepath+=~/.vim
  set wildmenu
  set wildignore=*.class,*.swp,*.swo
  set history=256
  set clipboard=unnamed " use the OS clipboard
  set binary
  set noeol
  set autochdir
  set modeline
  set modelines=4

  "" folding {{{
    set foldenable
    set foldmethod=indent
    set foldlevel=99
    set foldopen-=search
    set foldopen-=undo
  "" }}}

  "" backup and swap {{{
    set noswapfile
    set nobackup
  "" }}}

  "" encoding {{{
    set encoding=utf-8
    set fileencodings=utf-8
  "" }}}

  "" formatting {{{
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
    set expandtab
    set smarttab
    set autoindent
    set smartindent
  "" }}}

  "" grep {{{
    if executable('ag')
      set grepprg=ag\ --vimgrep
    elseif executable('awk')
      set grepprg=ack\ -H\ --nocolor\ --nogroup
    endif

    set grepformat=%f:%l:%c:%m
  "" }}}
"" }}}

"" key mappings {{{
  let mapleader=","
  let g:mapleader=","
  set backspace=indent,eol,start
  set mouse=a
  set mousehide
  nnoremap <silent> <Leader>/ :nohlsearch<CR>
  nnoremap <C-j><C-j> :m .+1<CR>==
  nnoremap <C-k><C-k> :m .-2<CR>==

  "" buffers {{{
    nnoremap <silent> <Leader>bd :bd<CR>
  "" }}}

  """ tabs {{{
    nnoremap <silent> <Tab><Tab> :tabnew<CR>
    nnoremap <silent> <Tab>q :tabclose<CR>
    nnoremap <silent> <Tab>o :tabonly<CR>
    nnoremap <silent> <Tab>s :tabs<CR>
    nnoremap <silent> <Tab>^ :tabfirst<CR>
    nnoremap <silent> <Tab>$ :tablast<CR>
    nnoremap <silent> <Tab>k :tabfirst<CR>
    nnoremap <silent> <Tab>j :tablast<CR>
    nnoremap <silent> <Tab>l :tabnext<CR>
    nnoremap <silent> <Tab>h :tabprev<CR>
    nnoremap <silent> <Tab>n :tabnext<CR>
    nnoremap <silent> <Tab>p :tabprev<CR>
    nnoremap <silent> <Tab><Right> :tabnext<CR>
    nnoremap <silent> <Tab><Left> :tabprev<CR>
    nnoremap <silent> <Tab>1 :tabnext 1<CR>
    nnoremap <silent> <Tab>2 :tabnext 2<CR>
    nnoremap <silent> <Tab>3 :tabnext 3<CR>
    nnoremap <silent> <Tab>4 :tabnext 4<CR>
    nnoremap <silent> <Tab>5 :tabnext 5<CR>
    nnoremap <silent> <Tab>6 :tabnext 6<CR>
    nnoremap <silent> <Tab>7 :tabnext 7<CR>
    nnoremap <silent> <Tab>8 :tabnext 8<CR>
    nnoremap <silent> <Tab>9 :tabnext 9<CR>
  """ }}}
"" }}}

"" plugins {{{
  call plug#begin('~/.vim/plugged')

  "" general {{{
    Plug 'easymotion/vim-easymotion'
    Plug 'tpope/vim-sensible'
  "" }}}

  "" appearance {{{
    Plug 'mhinz/vim-startify'
    let g:startify_bookmarks=[
          \ '~/.vimrc',
          \ '~/.zshrc',
          \]

    Plug 'vim-airline/vim-airline'
    let g:airline#extensions#tabline#enabled = 1
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='molokai'

    Plug 'chriskempson/base16-vim'
  "" }}}

  "" git {{{
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-git'
  "" }}}

  "" search {{{
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    map <leader>n <plug>NERDTreeTabsToggle<CR>
    map <leader>l :NERDTreeFind<cr>
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^\.git$', '^node_modules$', '^\.idea$']
    "let NERDTreeQuitOnOpen=1
    "let NERDTreeAutoDeleteBuffer=1
    "let NERDTreeMinimalUI = 1
    "let NERDTreeDirArrows = 1
    "close vim if only nerdtree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

    Plug 'kien/ctrlp.vim'
    let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
    "let NERDTreeShowBookmarks=1
    "let NERDTreeChDirMode=0
  "" }}}

  "" programming {{{
    Plug 'editorconfig/editorconfig-vim'
    let g:EditorConfig_exclude_patterns = ['fugitive://.*']

    Plug 'mtth/scratch.vim'
    Plug 'tpope/vim-surround'

    Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims=1
    let g:NERDCompactSexyComs=1
    let g:NERDDefaultAlign='left'
    let g:NERDCommentEmptyLines=1
    let g:NERDTrimTrailingWhitespace=1

    Plug 'valloric/youcompleteme', { 'for': 'javascript' }
    let g:ycm_add_preview_to_completeopt=0
    let g:ycm_confirm_extra_conf=0
    set completeopt-=preview

    Plug 'Raimondi/delimitMate', { 'for': 'javascript' }
    let g:delimitMate_expand_cr = 1

    Plug 'scrooloose/syntastic', { 'for': 'javascript' }
    let g:syntastic_check_on_open=1
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_javascript_checkers=['eslint']

    "" javascript {{{
      Plug 'jelera/vim-javascript-syntax', { 'for': 'javascript' }
      Plug 'moll/vim-node', { 'for': 'javascript' }
      Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
      Plug 'sidorares/node-vim-debugger', { 'for': 'javascript' }
      Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }

      "" esformatter (npm install -g esformatter)
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
    "" }}}
  "" }}}
  call plug#end()
"" }}}

"" theme {{{
  colorscheme base16-default-dark
  set guifont=InputMonoNarrow:h14

  "" visual {{{
    syntax on
    set number
    set ruler
    set showtabline=2
    set showcmd
    if exists('+colorcolumn')
      set colorcolumn=100
      highlight ColorColumn ctermbg=gray
    endif
    set cursorline
    augroup highlight_active_window
      autocmd!
      autocmd BufEnter * setlocal cursorline
      autocmd BufLeave * setlocal nocursorline
    augroup END
    set novisualbell
    set noerrorbells
    set scrolloff=3
    set statusline=%1*%{winnr()}\ %*%<\ %f\ %h%m%r%=%l,%c%V\ (%P)
    set laststatus=2
    set conceallevel=0

    "" colors {{{
      set t_Co=256
      if &term =~ '256color'
        set t_ut=
      endif
      set background=dark
    "" }}}

    "" searching and matching {{{
      set showmatch
      set matchtime=5
      set hlsearch " highlight matches...
      set incsearch " ...dynamically while typing
      set ignorecase " ignore case when searching...
      set smartcase " ...except when you're explicit with caps
    "" }}}
  "" }}}
"" }}}