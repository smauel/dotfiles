local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end
local function nmap(lhs, rhs, opts)
  map("n", lhs, rhs, opts)
end
local function imap(lhs, rhs, opts)
  map("i", lhs, rhs, opts)
end
local function vmap(lhs, rhs, opts)
  map("i", lhs, rhs, opts)
end

-- leader bindings
nmap("<leader>/", ":noh<cr>", { silent = true, desc = "Clear Highlight" })

-- split bindings
nmap("<C-J>", "<C-W><C-J>")
nmap("<C-K>", "<C-W><C-K>")
nmap("<C-L>", "<C-W><C-L>")
nmap("<C-H>", "<C-W><C-H>")

-- resize bindings
nmap("<C-Up>", "<cmd>resize +2<cr>")
nmap("<C-Down>", "<cmd>resize -2<cr>")
nmap("<C-Left>", "<cmd>vertical resize -2<cr>")
nmap("<C-Right>", "<cmd>vertical resize +2<cr>")

-- handle wrapped lines nicely
nmap("j", function(count) return count == 0 and "gj" or "j" end, { silent = true, expr = true })
nmap("k", function(count) return count == 0 and "gk" or "k" end, { silent = true, expr = true })

-- move lines up and down
nmap("<A-j>", ":m .+1<cr>==")
nmap("<A-k>", ":m .-2<cr>==")
imap("<A-j>", "<Esc>:m .+1<cr>==gi")
imap("<A-k>", "<Esc>:m .-2<cr>==gi")
vmap("<A-j>", ":m '>+1<cr>gv=gv")
vmap("<A-k>", ":m '<-2<cr>gv=gv")

-- make yank behave like delete and change
nmap("Y", "y$")

-- keep cursor centered when jumping around
nmap("n", "nzzzv")
nmap("N", "Nzzzv")
nmap("J", "mzJ`z")

-- undo breakpoints
imap(",", ",<c-g>u")
imap(".", ".<c-g>u")
imap(";", ";<c-g>u")
imap("!", "!<c-g>u")
imap("?", "?<c-g>u")

-- fat finger bindings
vim.cmd([[
  :command W w
  :command Wq wq
  :command Qa qa
  :command QA qa
  :command WQ wq
]])
