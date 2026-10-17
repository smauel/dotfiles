" ── Core ───────────────────────────────────────────────────
set nocompatible
filetype plugin indent on
syntax enable
set encoding=utf-8
scriptencoding utf-8

let mapleader = ","
let maplocalleader = " "

" ── Plugins (vim-plug, auto-installs on first launch) ──────
let s:plug = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug))
  silent execute '!curl -fLo ' . s:plug . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'        " fuzzy files, grep, buffers
  Plug 'tpope/vim-fugitive'      " git inside vim
  Plug 'airblade/vim-gitgutter'  " changed lines in the sign column
  Plug 'tpope/vim-surround'      " cs"' ds( ysiw]
  Plug 'tpope/vim-repeat'        " makes . work with surround
  Plug 'mbbill/undotree'         " browse persistent undo history
  Plug 'yegappan/lsp'            " native Vim 9 LSP client
  Plug 'cohama/lexima.vim'       " auto-close pairs, <CR> expansion
  Plug 'christoomey/vim-tmux-navigator'  " C-hjkl across vim splits and tmux panes
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }  " colorscheme
  Plug 'JalaiAmitahl/maven-compiler.vim'
call plug#end()

" ── UI ─────────────────────────────────────────────────────
set number relativenumber
set cursorline
set signcolumn=yes          " no layout jump when signs appear
set scrolloff=8 sidescrolloff=8
set laststatus=2
set showcmd
set noshowmode
set wildmenu
set wildmode=longest:full,full
set wildoptions=pum,fuzzy   " popup + fuzzy cmdline completion (Vim 9)
set wildignore+=*/.git/*,*/node_modules/*,*/target/*,*/build/*,*.class,*.jar
set splitright splitbelow
set nowrap
set list listchars=tab:»\ ,trail:·,nbsp:␣,extends:›,precedes:‹
set fillchars=vert:│
set belloff=all
set shortmess+=c
set display=lastline
set colorcolumn=120

if has('termguicolors')
  set termguicolors
endif
set background=dark
silent! colorscheme catppuccin_mocha

" ── Editing ────────────────────────────────────────────────
set expandtab
set tabstop=4 shiftwidth=4 softtabstop=4
set shiftround
set autoindent smartindent
set backspace=indent,eol,start
set nojoinspaces
set formatoptions+=j         " strip comment leaders on join
set virtualedit=block
set mouse=a
set ttymouse=sgr
set clipboard=unnamedplus    " needs +clipboard (Arch: install gvim)
set completeopt=menuone,noinsert,noselect,popup
set pumheight=15

" ── Search ─────────────────────────────────────────────────
set ignorecase smartcase
set incsearch hlsearch
set gdefault                 " :s defaults to /g

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

" ── Performance / responsiveness ───────────────────────────
set updatetime=250
set ttimeout ttimeoutlen=10
set timeoutlen=500
set lazyredraw
set hidden
set autoread

" ── Files: persistent undo, no swap clutter ────────────────
let s:vimdir = expand('~/.local/state/vim')
if !isdirectory(s:vimdir . '/undo/')
	call mkdir(s:vimdir . '/undo/', 'p', 0700)
endif
let &undodir   = s:vimdir . '/undo//'
set undofile undolevels=10000
set noswapfile
set nowritebackup
set viminfofile=~/.local/state/vim/viminfo

" ── Built-in plugins ───────────────────────────────────────
packadd! matchit
silent! packadd! comment      " gcc / gc{motion} commenting (Vim 9.1+)
silent! packadd! editorconfig " respect .editorconfig (Vim 9.0.1799+)
packadd! cfilter              " :Cfilter / :Lfilter to narrow quickfix/location lists
let g:hlyank_duration = 150
silent! packadd! hlyank       " briefly highlight yanked text (Vim 9.1+)
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_winsize = 25

" ── Keymaps: general ───────────────────────────────────────
" Clear search highlight
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Buffers
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>

" File explorer
nnoremap <leader>l :Lexplore<CR>

" Quickfix and location lists
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprevious<CR>zz
nnoremap <silent> <leader>q :call <SID>ToggleQuickfix()<CR>
nnoremap <silent> <leader>m :call <SID>ToggleLoclist()<CR>

function! s:ToggleQuickfix() abort
  if getqflist({'winid': 0}).winid
    cclose
  else
    copen
  endif
endfunction

function! s:ToggleLoclist() abort
  if getloclist(0, {'winid': 0}).winid
    lclose
  elseif getloclist(0, {'id': 0}).id
    lopen
  else
    echo 'No location list'
  endif
endfunction

" Keep search results centred
nnoremap n nzzzv
nnoremap N Nzzzv

" Move lines in visual mode, keep selection when indenting
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
vnoremap < <gv
vnoremap > >gv

" Y yanks to end of line (consistent with D, C)
nnoremap Y y$

" Quick edit/reload vimrc
nnoremap <leader>ve :edit $MYVIMRC<CR>
nnoremap <leader>vr :source $MYVIMRC<CR>

" ── Fat-finger commands ────────────────────────────────────
" Any capitalisation of these (W, Wq, QA, ...) expands to lowercase, but only when
" it's the whole command, so :W foo still works and :Qa! becomes :qa!
function! s:CaseVariants(word) abort
  if a:word ==# ''
    return ['']
  endif
  let l:rest = s:CaseVariants(a:word[1:])
  return map(copy(l:rest), 'a:word[0] . v:val') + map(copy(l:rest), 'toupper(a:word[0]) . v:val')
endfunction

function! s:FatFinger(typo, cmd) abort
  execute printf("cnoreabbrev <expr> %s getcmdtype() ==# ':' && getcmdline() ==# '%s' ? '%s' : '%s'",
        \ a:typo, a:typo, a:cmd, a:typo)
endfunction

for s:cmd in ['w', 'q', 'wq', 'wa', 'qa', 'wqa', 'x', 'xa']
  for s:typo in s:CaseVariants(s:cmd)[1:]
    call s:FatFinger(s:typo, s:cmd)
  endfor
endfor
for s:typo in s:CaseVariants('qw')
  call s:FatFinger(s:typo, 'wq')
endfor

" ── Keymaps: JSON formatting ───────────────────────────────
" jq when the text is valid JSON, otherwise a basic split on brackets and commas
nnoremap <silent> <leader>jj :call <SID>FormatJsonLines(1, line('$'))<CR>
xnoremap <silent> <leader>jj :<C-u>call <SID>FormatJsonSelection()<CR>

function! s:FormatJsonLines(first, last) abort
  let l:whole = a:first == 1 && a:last == line('$')
  let l:out = s:FormatJson(join(getline(a:first, a:last), "\n"))
  silent call deletebufline('', a:first, a:last)
  call append(a:first - 1, l:out)
  if l:whole
    silent call deletebufline('', '$')
  endif
endfunction

function! s:FormatJsonSelection() abort
  " Linewise and blockwise selections format whole lines
  if visualmode() !=# 'v'
    return s:FormatJsonLines(line("'<"), line("'>"))
  endif
  let l:text = getregion(getpos("'<"), getpos("'>"), {'type': 'v'})
  let l:save = getreginfo('z')
  call setreg('z', s:FormatJson(join(l:text, "\n")), 'c')
  normal! gv"zP
  call setreg('z', l:save)
endfunction

function! s:FormatJson(text) abort
  if executable('jq')
    echo 'Formatting JSON with jq'
    let l:out = systemlist('jq --indent ' . min([shiftwidth(), 7]) . ' .', a:text)
    if !v:shell_error
      return l:out
    endif
  elseif !executable('jq')
    echo 'jq not installed'
  endif
  echo 'Formatting JSON with naive newlines'
  return s:FormatJsonBasic(a:text)
endfunction

" Break lines after { [ and , and before } ], skipping anything inside quotes
function! s:FormatJsonBasic(text) abort
  let l:pad = repeat(' ', shiftwidth())
  let l:lines = ['']
  let l:depth = 0
  let l:quote = ''
  let l:escaped = 0
  let l:space = 0
  for l:c in split(a:text, '\zs')
    if l:quote !=# ''
      let l:lines[-1] .= l:c
      if l:escaped
        let l:escaped = 0
      elseif l:c ==# '\'
        let l:escaped = 1
      elseif l:c ==# l:quote
        let l:quote = ''
      endif
    elseif l:c =~# '\s'
      let l:space = 1
    elseif l:c =~# '[{[]'
      let l:lines[-1] .= l:c
      let l:depth += 1
      call add(l:lines, repeat(l:pad, l:depth))
      let l:space = 0
    elseif l:c =~# '[}\]]'
      let l:depth = max([l:depth - 1, 0])
      if l:lines[-1] =~# '^\s*$'
        " Empty pair, or nothing since the last comma: close on the same line
        call remove(l:lines, -1)
      else
        call add(l:lines, repeat(l:pad, l:depth))
      endif
      let l:lines[-1] .= l:c
      let l:space = 0
    elseif l:c ==# ','
      let l:lines[-1] .= l:c
      call add(l:lines, repeat(l:pad, l:depth))
      let l:space = 0
    elseif l:c ==# ':'
      let l:lines[-1] .= ': '
      let l:space = 0
    else
      if l:space && l:lines[-1] !~# '\(^\s*\|: \)$'
        let l:lines[-1] .= ' '
      endif
      let l:space = 0
      let l:lines[-1] .= l:c
      if l:c =~# '["'']'
        let l:quote = l:c
      endif
    endif
  endfor
  return filter(l:lines, 'v:val !~# "^\\s*$"')
endfunction

" ── Keymaps: fzf ───────────────────────────────────────────
nnoremap <leader>p :Files<CR>
nnoremap <leader>r :Rg<CR>
nnoremap <leader>bb :Buffers<CR>
nnoremap <leader>gg :BLines<CR>
nnoremap <leader>gf :GFiles?<CR>

" ── Keymaps: git ───────────────────────────────────────────
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gl :Git log --oneline<CR>
" gitgutter defaults: ]c [c jump hunks, <leader>hp preview, hs stage, hu undo

" ── Keymaps: undo tree ─────────────────────────────────────
nnoremap <leader>u :UndotreeToggle<CR>

" ── Keymaps: maven ─────────────────────────────────────────────────────
autocmd Filetype java compiler mvn
autocmd Filetype pom compiler mvn
autocmd Filetype java no <F2> :make clean package<CR>

" ── LSP ────────────────────────────────────────────────────
" Install servers separately: jdtls (AUR), yaml-language-server, bash-language-server
autocmd User LspSetup call LspOptionsSet(#{autoComplete: v:true, showDiagWithVirtualText: v:false})
autocmd User LspSetup call LspAddServer([
      \ #{name: 'jdtls',  filetype: ['java'],        path: 'jdtls',                args: []},
      \ ])

" Buffer-local maps, only where a server is attached
function! s:LspMaps() abort
  nnoremap <buffer> gd         :LspGotoDefinition<CR>
  nnoremap <buffer> gr         :LspShowReferences<CR>
  nnoremap <buffer> gi         :LspGotoImpl<CR>
  nnoremap <buffer> K          :LspHover<CR>
  nnoremap <buffer> <leader>rn :LspRename<CR>
  nnoremap <buffer> <leader>ca :LspCodeAction<CR>
  nnoremap <buffer> <leader>fm :LspFormat<CR>
  nnoremap <buffer> <leader>ds :LspDocumentSymbol<CR>
  nnoremap <buffer> ]d         :LspDiag next<CR>
  nnoremap <buffer> [d         :LspDiag prev<CR>
endfunction

" ── Autocommands ───────────────────────────────────────────
augroup vimrc
  autocmd!
  autocmd User LspAttached call s:LspMaps()

  " Restore last cursor position
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line('$') && &ft !~# 'commit'
        \ | exe 'normal! g`"' | endif

  " Strip trailing whitespace on save (keeps cursor/view)
  autocmd BufWritePre * if &ft !~# 'markdown\|diff'
        \ | let s:v = winsaveview() | keeppatterns %s/\s\+$//e
        \ | call winrestview(s:v) | endif

  " Open quickfix after :grep
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow

  " Reload files changed outside vim
  autocmd FocusGained,BufEnter * silent! checktime

  " Per-language indent
  autocmd FileType gitcommit,markdown setlocal spell wrap linebreak
augroup END

" ── Statusline (no plugin) ─────────────────────────────────
set statusline=
set statusline+=\ %{toupper(mode())}\ │
set statusline+=\ %f%m%r%h
set statusline+=\ %{exists('*FugitiveHead')&&FugitiveHead()!=''?'\ '.FugitiveHead():''}
set statusline+=%=
set statusline+=%y\ │\ %{&fenc?&fenc:&enc}\ │\ %l:%c\ │\ %p%%\
