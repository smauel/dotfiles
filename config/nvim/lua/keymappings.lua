local ts = require("config.telescope")
local m = require("mapx").setup({ whichkey = true })

-- leader bindings
m.nname("<leader>", "Leader")
m.nnoremap("<leader>/", ":noh<cr>", "silent", "Clear Highlight")
m.nnoremap("<leader>b", ts.buffers, "silent", "Telescope Buffers")
m.nnoremap("<leader>c", ts.commits, "silent", "Telescope Commits")
m.nnoremap("<leader>f", ":NvimTreeFindFile<cr>", "silent", "NvimTree Find File")
m.nnoremap("<leader>gd", ts.git_status, "silent", "Telescope Git Diff")
m.nnoremap("<leader>gf", ts.git_files, "silent", "Telescope Git Files")
m.nnoremap("<leader>l", ":NvimTreeToggle<cr>", "silent", "NvimTree Toggle")
m.nnoremap("<leader>p", ts.find_files, "silent", "Telescope Files")
m.nnoremap("<leader>q", ts.quickfix, "silent", "Telescope Quickfix")
m.nnoremap("<leader>r", ts.live_grep, "silent", "Telescope Grep")
m.nnoremap("<leader>v", ts.find_config_files, "silent", "Telescope Config Files")
m.nnoremap("<leader>z", ts.colorscheme, "silent", "Telescope Colorschemes")

m.nnoremap('][q', ':copen<cr>', 'silent', 'Open Quickfix List')
m.nnoremap('[]q', ':cclose<cr>', 'silent', 'Close Quickfix List')
m.nnoremap('][l', ':lopen<cr>', 'silent', 'Open Location List')
m.nnoremap('[]l', ':lclose<cr>', 'silent', 'Close Location List')

-- split bindings
m.nnoremap("<C-J>", "<C-W><C-J>")
m.nnoremap("<C-K>", "<C-W><C-K>")
m.nnoremap("<C-L>", "<C-W><C-L>")
m.nnoremap("<C-H>", "<C-W><C-H>")

-- handle wrapped lines nicely
m.nnoremap("j", function(count)
	return count > 0 and "j" or "gj"
end, "silent", "expr")
m.nnoremap("k", function(count)
	return count > 0 and "k" or "gk"
end, "silent", "expr")

-- move lines up and down
m.nnoremap("<A-j>", ":m .+1<cr>==")
m.nnoremap("<A-k>", ":m .-2<cr>==")
m.inoremap("<A-j>", "<Esc>:m .+1<cr>==gi")
m.inoremap("<A-k>", "<Esc>:m .-2<cr>==gi")
m.vnoremap("<A-j>", ":m '>+1<cr>gv=gv")
m.vnoremap("<A-k>", ":m '<-2<cr>gv=gv")

-- make yank behave like delete and change
m.nnoremap("Y", "y$")

-- keep cursor centered when jumping around
m.nnoremap("n", "nzzzv")
m.nnoremap("N", "Nzzzv")
m.nnoremap("J", "mzJ`z")

-- undo breakpoints
m.inoremap(",", ",<c-g>u")
m.inoremap(".", ".<c-g>u")
m.inoremap(";", ";<c-g>u")
m.inoremap("!", "!<c-g>u")
m.inoremap("?", "?<c-g>u")

-- fat finger bindings
vim.cmd([[
  :command W w
  :command Wq wq
  :command Qa qa
  :command QA qa
  :command WQ wq
]])
