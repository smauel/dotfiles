---@diagnostic disable: undefined-global
vim.g.mapleader = "," -- Set leader key
vim.g.maplocalleader = "," -- Set local leader key

-- ============================================================================
-- PLUGINS
-- ============================================================================
vim.pack.add({
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/mcauley-penney/techbase.nvim" },
  { src = "https://github.com/OXY2DEV/markview.nvim" },
  { src = "https://codeberg.org/mfussenegger/nvim-jdtls.git" },
  { src = "https://github.com/nvim-neotest/neotest" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/rcasia/neotest-java" },
})

require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "jdtls" } })
require("gitsigns").setup()
require("mini.basics").setup()
require("mini.completion").setup()
require("mini.icons").setup()
require("mini.keymap").setup()
require("mini.pairs").setup()
require("mini.statusline").setup()
require("mini.surround").setup()
require("nvim-treesitter").install({ "lua", "bash", "zsh", "java", "xml", "json", "yaml" })
require("nvim-treesitter").setup()
require("nvim-ts-autotag").setup()
require("snacks").setup()
require("markview").setup()
require("neotest").setup({
  adapters = {
    require("neotest-java"),
  },
})

-- Workspace path - one per project
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.expand("$HOME/.local/share/nvim/jdtls-workspace/") .. project_name
local jdtls_path = vim.fn.expand("$HOME/.local/share/nvim/mason/packages/jdtls")
local lombok_path = vim.fn.expand("$HOME/.local/share/nvim/mason/share/jdtls/lombok.jar")

vim.lsp.config("jdtls", {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- Add Lombok as a javaagent
    "-javaagent:" .. lombok_path,
    "-jar",
    vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    jdtls_path .. "/config_linux",
    "-data",
    workspace_dir,
  },
})

-- default language formatters
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    sh = { "shfmt" },
    java = { "palantir-java-format" },
  },
})

-- completion keymaps
local map_multistep = require("mini.keymap").map_multistep
map_multistep("i", "<Tab>", { "pmenu_next" })
map_multistep("i", "<S-Tab>", { "pmenu_prev" })
map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
map_multistep("i", "<BS>", { "minipairs_bs" })

-- ============================================================================
-- OPTIONS
-- ============================================================================

-- Basic settings
vim.opt.relativenumber = true -- Relative line numbers

-- Colorscheme
vim.cmd.colorscheme("techbase")

-- Indentation
vim.opt.tabstop = 2 -- Tab width
vim.opt.shiftwidth = 2 -- Indent width
vim.opt.softtabstop = 2 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line

-- Search settings
vim.opt.hlsearch = true -- Highlight search results

-- Visual settings
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.matchtime = 2 -- How long to show matching bracket
vim.opt.cmdheight = 1 -- Command line height
vim.opt.pumheight = 10 -- Popup menu height
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Floating window transparency
vim.opt.conceallevel = 0 -- Don't hide markup
vim.opt.concealcursor = "" -- Don't hide cursor line markup
vim.opt.lazyredraw = true -- Don't redraw during macros
vim.opt.synmaxcol = 300 -- Syntax highlighting limit
vim.opt.fillchars = { eob = " " } -- Hide ~ on empty lines

-- File handling
vim.opt.updatetime = 300 -- Faster completion
vim.opt.timeoutlen = 500 -- Key timeout duration
vim.opt.ttimeoutlen = 0 -- Key code timeout
vim.opt.autoread = true -- Auto reload files changed outside vim
vim.opt.autowrite = false -- Don't auto save

-- Behavior settings
vim.opt.hidden = true -- Allow hidden buffers
vim.opt.errorbells = false -- No error bells
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior
vim.opt.autochdir = false -- Don't auto change directory
vim.opt.path:append("**") -- include subdirectories in search
vim.opt.selection = "exclusive" -- Selection behavior
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.clipboard:append("unnamedplus") -- Use system clipboard
vim.opt.modifiable = true -- Allow buffer modifications
vim.opt.encoding = "UTF-8" -- Set encoding

-- Folding settings
vim.opt.foldmethod = "expr" -- Use expression for folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folding
vim.opt.foldlevel = 99 -- Start with all folds open

-- ============================================================================
-- KEYMAPS
-- ============================================================================

-- Normal mode mappings
vim.keymap.set("n", "<leader>/", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- Snacks mappings
vim.keymap.set("n", "<leader>l", function()
  require("snacks").explorer({ hidden = true })
end, { desc = "Explorer" })

vim.keymap.set("n", "<leader>p", function()
  require("snacks").picker.files({ hidden = true })
end, { desc = "File Picker" })

vim.keymap.set("n", "<leader>r", function()
  require("snacks").picker.grep({ hidden = true })
end, { desc = "Grep" })

vim.keymap.set("n", "<leader>sh", function()
  require("snacks").picker.help()
end, { desc = "Help" })

vim.keymap.set("n", "<leader>sd", function()
  require("snacks").picker.diagnostics()
end, { desc = "Diagnostics" })

vim.keymap.set("n", "<leader>sg", function()
  require("snacks").lazygit()
end, { desc = "Git" })

-- Y to EOL
vim.keymap.set("n", "Y", "y$", { desc = "Yank to end of line" })

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Splitting & Resizing
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
vim.keymap.set("n", "<leader>e", ":Explore<CR>", { desc = "Open file explorer" })
vim.keymap.set("n", "<leader>f", ":find ", { desc = "Find file" })

-- Better J behavior
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e $MYVIMRC<CR>", { desc = "Edit config" })
vim.keymap.set("n", "<leader>rl", ":so $MYVIMRC<CR>", { desc = "Reload config" })

-- NeoTest
vim.keymap.set("n", "<leader>tt", function()
  require("neotest").run.run()
end, { desc = "Run Test Method" })

vim.keymap.set("n", "<leader>tT", function()
  require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run Test Class" })

vim.keymap.set("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Run Test Class" })

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    local line = mark[1]
    local ft = vim.bo.filetype
    if line > 0 and line <= lcount and vim.fn.index({ "commit", "gitrebase", "xxd" }, ft) == -1 and not vim.o.diff then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-close terminal when process exits
vim.api.nvim_create_autocmd("TermClose", {
  group = augroup,
  callback = function()
    if vim.v.event.status == 0 then
      vim.api.nvim_buf_delete(0, {})
    end
  end,
})

-- Disable line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
  group = augroup,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

-- turn completion off in snacks picker
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  pattern = "snacks_picker_input",
  desc = "Disable mini.completion for snacks picker",
  command = "lua vim.b.minicompletion_disable=true",
})

-- ============================================================================
-- LSP CONFIGURATION
-- ============================================================================

-- LSP settings
local function setup_lsp()
  -- Show diagnostic signs in the gutter
  local signs = {
    Error = "\u{f06a} ", -- nf-fa-exclamation_circle
    Warn = "\u{f071} ", -- nf-fa-exclamation_triangle
    Hint = "\u{f0eb} ", -- nf-fa-lightbulb_o
    Info = "\u{f05a} ", -- nf-fa-info_circle
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Diagnostic configuration
  vim.diagnostic.config({
    virtual_text = {
      prefix = "●",
      spacing = 4,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  })

  -- LSP keymaps (set when LSP attaches)
  vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    callback = function(ev)
      local opts = { buffer = ev.buf }
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
      vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })
      end, opts)
    end,
  })

  -- Floating window borders
  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or "rounded"
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end
end

setup_lsp()
