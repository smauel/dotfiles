-- Settings
-- See `:help vim.o`

-- leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- colors
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd [[colorscheme onedark]]

-- general
vim.o.hidden = true
vim.o.clipboard = 'unnamedplus'
vim.o.binary = true
vim.o.eol = false
vim.o.modeline = true
vim.o.modelines = 4
vim.o.cmdheight = 1
vim.o.lazyredraw = true
vim.o.showmode = false
vim.o.updatetime = 250
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.scrolloff = 3
vim.o.encoding = 'utf-8'
vim.o.list = false
vim.o.completeopt = 'menuone,noselect'

-- backup and swap
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false

-- formatting
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.joinspaces = false
vim.o.autoindent = true
vim.o.formatoptions = vim.o.formatoptions .. "j"

-- search
vim.o.showmatch = true
vim.o.matchtime = 5
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- visual
vim.o.number = true
vim.o.relativenumber = true
vim.o.showtabline = 2
vim.o.showcmd = true
vim.o.cursorline = true
vim.o.visualbell = false
vim.o.errorbells = false
vim.o.conceallevel = 0
vim.o.signcolumn = 'number'

-- splits
vim.o.splitbelow = true
vim.o.splitright = true
