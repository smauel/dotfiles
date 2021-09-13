scriptencoding utf-8

" lua plugins
lua <<EOF
require('plugins')
require('settings')
require('keymappings')
EOF


" coc settings TODO: convert to lua
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
