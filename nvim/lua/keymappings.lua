local m = require'mapx'.setup{ global = true, whichkey = true }

-- leader bindings
m.nname('<leader>', 'Leader')
m.nnoremap('<leader>/', ':noh<cr>', 'silent', 'Clear Highlight')
m.nnoremap('<leader>a', '<Plug>(coc-codeaction-cursor)', 'silent', 'Coc Fix Current')
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
m.nmap('gd', '<Plug>(coc-definition)', 'silent', 'Goto Definition')
m.nmap('gi', '<Plug>(coc-implementation)', 'silent', 'Goto Implementation')
m.nmap('gn', '<Plug>(coc-diagnostic-next)', 'silent', 'Goto Next Diagnostic')
m.nmap('gp', '<Plug>(coc-diagnostic-prev)', 'silent', 'Goto Prev Diagnostic')
m.nmap('gr', '<Plug>(coc-references)', 'silent', 'Goto References')

-- coc bindings
m.nname('<space>', 'Coc')
m.nnoremap('<space>a', ':<C-u>Telescope coc file_code_actions<cr>', 'silent', 'Coc Code Actions')
m.nnoremap('<space>c', ':<C-u>Telescope coc commands<cr>', 'silent', 'Coc Commands')
m.nnoremap('<space>d', ':<C-u>Telescope coc definitions<cr>', 'silent', 'Coc Definitions')
m.nnoremap('<space>e', ':<C-u>CocList extensions<cr>', 'silent', 'Coc Extensions')

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
