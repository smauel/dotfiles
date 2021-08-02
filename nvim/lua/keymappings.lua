vim.g.mapleader = ','

vim.cmd([[
inoremap <silent> <expr> <CR>      compe#confirm('<CR>')

" leader mappings
nnoremap <silent> <leader>/ :set hlsearch!<cr>
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
nnoremap <silent> gn <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> gp <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gs <cmd>lua vim.lsp.buf.signature_help()<CR>

" codeaction bindings
nnoremap <silent> ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> cr <cmd>lua require('lspsaga.rename').rename()<CR>

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
]])
