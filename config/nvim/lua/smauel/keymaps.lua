-- Keymaps
local ts = require('smauel.config.telescope')
local m = require("mapx").setup({ whichkey = true })

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>,', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' })

-- leader bindings
m.nname("<leader>", "Leader")
m.nnoremap("<leader>/", ":noh<cr>", "silent", "Clear Highlight")
m.nnoremap("<leader>?", ts.file_browser, "silent", "Telescope Recent Files")
m.nnoremap("<leader>b", ts.buffers, "silent", "Telescope Buffers")
m.nnoremap("<leader>d", ":TroubleToggle<cr>", "silent", "Telescope Diagnostics")
m.nnoremap("<leader>e", vim.diagnostic.open_float, "silent", "Open Float Diagnostics")
m.nnoremap("<leader>f", ":NvimTreeFindFile<cr>", "silent", "NvimTree Find File")
m.nnoremap("<leader>gb", ts.git_branches, "silent", "Telescope Git Branches")
m.nnoremap("<leader>gc", ts.git_commits, "silent", "Telescope Git Commits")
m.nnoremap("<leader>gf", ts.git_files, "silent", "Telescope Git Files")
m.nnoremap("<leader>gs", ts.git_status, "silent", "Telescope Git Status")
m.nnoremap("<leader>h", ts.help_tags, "silent", "Telescope Help")
m.nnoremap("<leader>k", ts.keymaps, "silent", "Telescope Keymaps")
m.nnoremap("<leader>l", ":NvimTreeToggle<cr>", "silent", "NvimTree Toggle")
m.nnoremap("<leader>o", ":AerialToggle<cr>", "silent", "Aerial Outline")
m.nnoremap("<leader>p", ts.find_files, "silent", "Telescope Files")
m.nnoremap("<leader>q", ts.quickfix, "silent", "Telescope Quickfix")
m.nnoremap("<leader>r", ts.live_grep, "silent", "Telescope Grep")
m.nnoremap("<leader>v", ts.find_config_files, "silent", "Telescope Config Files")
m.nnoremap("<leader>x", ts.command_history, "silent", "Telescope Command History")
m.nnoremap("<leader>z", ts.colorscheme, "silent", "Telescope Colorschemes")

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
