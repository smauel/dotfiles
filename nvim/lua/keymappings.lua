local m = require'mapx'.setup{ global = true, whichkey = true }

-- leader bindings
m.nname('<leader>', 'Leader')
m.nnoremap('<leader>/', ':noh<cr>', 'silent', 'Clear Highlight')
m.nnoremap('<leader>a', ':<C-u>Telescope coc line_code_actions<cr>', 'silent', 'Coc Fix Current')
m.nnoremap('<leader>b', function() require('config.telescope').buffers() end, 'silent', 'Telescope Buffers')
m.nnoremap('<leader>c', function() require('config.telescope').commits() end, 'silent', 'Telescope Commits')
m.nnoremap('<leader>d', ':bd<cr>', 'silent', 'Close Buffer')
m.nnoremap('<leader>f', ':NvimTreeFindFile<cr>', 'silent', 'NvimTree Find File')
m.nnoremap('<leader>gb', ':GBrowse<cr>', 'silent', 'Open In Github')
m.nnoremap('<leader>gf', function() require('config.telescope').git_files() end, 'silent', 'Telescope Git Files')
m.nnoremap('<leader>l', ':NvimTreeToggle<cr>', 'silent', 'NvimTree Toggle')
m.nnoremap('<leader>m', ':Git<cr>', 'silent', 'Fugitive')
m.nnoremap('<leader>p', function() require('config.telescope').find_files() end, 'silent', 'Telescope Files')
m.nnoremap('<leader>q', function() require('config.telescope').quickfix() end, 'silent', 'Telescope Quickfix')
m.nnoremap('<leader>r', function() require('config.telescope').live_grep() end, 'silent', 'Telescope Grep')
m.nnoremap('<leader>v', function() require('config.telescope').find_config_files() end, 'silent', 'Telescope Config Files')
m.nnoremap('<leader>z', function() require('config.telescope').colorscheme() end, 'silent', 'Telescope Colorschemes')

-- goto bindings
m.nname('g', 'Goto bindings')
m.nmap('gd', ':<C-u>Telescope coc definitions<cr>', 'silent', 'Goto Definition')
m.nmap('gi', ':<C-u>Telescope coc implementations<cr>', 'silent', 'Goto Implementation')
m.nmap('gr', ':<C-u>Telescope coc references<cr>', 'silent', 'Goto References')

-- coc bindings
m.nname('<space>', 'Coc')
m.nnoremap('<space>a', ':<C-u>Telescope coc file_code_actions<cr>', 'silent', 'Coc Code Actions')
m.nnoremap('<space>c', ':<C-u>Telescope coc commands<cr>', 'silent', 'Coc Commands')
m.nnoremap('<space>d', ':<C-u>Telescope coc diagnostics<cr>', 'silent', 'Coc Diagnostics')
m.nnoremap('<space>e', ':<C-u>CocList extensions<cr>', 'silent', 'Coc Extensions')
m.nnoremap('<space>o', ':<C-u>Telescope coc document_symbols<cr>', 'silent', 'Coc Outline')

-- unimpaired enhanced bindings
m.nnoremap(']a', '<Plug>(coc-diagnostic-next)', 'silent', 'Goto Next Diagnostic')
m.nnoremap('[a', '<Plug>(coc-diagnostic-prev)', 'silent', 'Goto Prev Diagnostic')
m.nnoremap('][a', ':CocList diagnostics<cr>', 'silent', 'Open Diagnostics List')
m.nnoremap('][q', ':copen<cr>', 'silent', 'Open Quickfix List')
m.nnoremap('[]q', ':cclose<cr>', 'silent', 'Close Quickfix List')
m.nnoremap('][l', ':lopen<cr>', 'silent', 'Open Location List')
m.nnoremap('[]l', ':lclose<cr>', 'silent', 'Close Location List')

-- test bindings
m.nname('t', 'Test bindings')
m.nmap('tf', ':Ultest<cr>', 'silent', 'Run Tests In File')
m.nmap('ts', ':TestSuite<cr>', 'silent', 'Run All Tests')
m.nmap('tt', ':UltestNearest<cr>', 'silent', 'Run Test')

-- split bindings
m.nnoremap('<C-J>', '<C-W><C-J>')
m.nnoremap('<C-K>', '<C-W><C-K>')
m.nnoremap('<C-L>', '<C-W><C-L>')
m.nnoremap('<C-H>', '<C-W><C-H>')

-- handle wrapped lines nicely
m.nnoremap("j", function(count) return count > 0 and "j" or "gj" end, "silent", "expr")
m.nnoremap("k", function(count) return count > 0 and "k" or "gk" end, "silent", "expr")

-- move lines up and down
m.nnoremap('<A-j>', ':m .+1<cr>==')
m.nnoremap('<A-k>', ':m .-2<cr>==')
m.inoremap('<A-j>', '<Esc>:m .+1<cr>==gi')
m.inoremap('<A-k>', '<Esc>:m .-2<cr>==gi')
m.vnoremap('<A-j>', ":m '>+1<cr>gv=gv")
m.vnoremap('<A-k>', ":m '<-2<cr>gv=gv")

-- fat finger bindings
vim.cmd[[
  :command W w
  :command Wq wq
  :command Qa qa
  :command QA qa
  :command WQ wq
]]
