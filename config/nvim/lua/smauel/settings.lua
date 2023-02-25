-- Settings
-- See `:help vim.o`
local opt = vim.o

-- leader
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- colors
opt.termguicolors = true
opt.background = 'dark'
vim.cmd [[colorscheme tokyonight]]

-- general
opt.hidden = true
opt.clipboard = 'unnamedplus'
opt.binary = true
opt.eol = false
opt.modeline = true
opt.modelines = 4
opt.cmdheight = 1
opt.lazyredraw = true
opt.showmode = false
opt.updatetime = 250
opt.shortmess = opt.shortmess .. 'c'
opt.scrolloff = 3
opt.encoding = 'utf-8'
opt.list = false
opt.completeopt = 'menu,menuone,noselect'

-- backup and swap
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- formatting
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.smarttab = true
opt.joinspaces = false
opt.autoindent = true
opt.copyindent = true
opt.formatoptions = opt.formatoptions .. "j"

-- search
opt.showmatch = true
opt.matchtime = 5
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- visual
opt.number = true
opt.relativenumber = true
opt.showtabline = 2
opt.showcmd = true
opt.cursorline = true
opt.visualbell = false
opt.errorbells = false
opt.conceallevel = 0
opt.signcolumn = 'number'

-- splits
opt.splitbelow = true
opt.splitright = true
