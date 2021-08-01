local o = vim.o
local g = vim.g

-- colors
o.guifont = 'SpaceMonoNerdFontCompleteM-Regular:h15'
o.termguicolors = true
o.background = 'dark'
g.material_style = 'deep ocean'
g.material_italic_comments = true
g.material_italic_keywords = false
g.material_italic_functions = false
g.material_italic_variables = false
g.material_contrast = true
g.material_borders = false
g.material_disable_background = false
g.material_hide_eob = true
require('material').set()

-- general
o.hidden = true
o.clipboard = 'unnamed'
o.binary = true
o.eol = false
o.modeline = true
o.modelines = 4
o.cmdheight = 1
o.lazyredraw = true
o.showmode = false
o.updatetime = 300
o.shortmess = o.shortmess .. 'c'
o.scrolloff = 3
o.encoding = 'utf-8'

-- backup and swap
o.swapfile = false
o.backup = false
o.writebackup = false

-- formatting
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.smarttab = true
o.joinspaces = false
o.autoindent = true
o.formatoptions= o.formatoptions .. 'j'

-- search
o.showmatch = true
o.matchtime = 5
o.hlsearch = true
o.ignorecase = true -- ignore case when searching...
o.smartcase = true -- ...except when you're explicit with caps

-- visual
o.number = true
o.relativenumber = true
o.showtabline = 2
o.showcmd = true
o.cursorline = true
o.visualbell = false
o.errorbells = false
o.conceallevel = 0
o.signcolumn = 'number' -- merge signcolumn and number column into one
