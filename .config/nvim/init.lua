-----------------------------------------------------
-- Leader
-----------------------------------------------------
vim.g.mapleader = ","

-----------------------------------------------------
-- Basics
-----------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true

-----------------------------------------------------
-- Lazy
-----------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------
-- Plugins
-----------------------------------------------------
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{ "nvim-tree/nvim-tree.lua", config = true },
	{ "nvim-lualine/lualine.nvim", opts = { options = { theme = "tokyonight" } } },
	{ "nvim-telescope/telescope.nvim", tag = "0.1.4", dependencies = { "nvim-lua/plenary.nvim" } },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim", config = true },
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "pyright", "ts_ls" },
			automatic_installation = true,
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier" },
			},
			format_on_save = {
				lsp_fallback = true,
				timeout_ms = 500,
			},
		},
	},
	{ "zapling/mason-conform.nvim", config = true },
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
		keys = {
			{
				"<leader>x",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
		},
	},
	{ "christoomey/vim-tmux-navigator", lazy = false },
	{ "echasnovski/mini.pairs", config = true },
	{ "lewis6991/gitsigns.nvim", config = true },
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"bash",
				"diff",
				"html",
				"javascript",
				"jsdoc",
				"json",
				"jsonc",
				"lua",
				"luadoc",
				"luap",
				"markdown",
				"markdown_inline",
				"printf",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"vimdoc",
				"xml",
				"yaml",
			},
		},
	},
})

-----------------------------------------------------
-- NvimTree
-----------------------------------------------------
require("nvim-tree").setup()

-----------------------------------------------------
-- LuaLine
-----------------------------------------------------
require("lualine").setup({})

-----------------------------------------------------
-- Mappings
-----------------------------------------------------
vim.keymap.set("n", "<leader>l", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>p", "<cmd>Telescope find_files hidden=true<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>r", "<cmd>Telescope live_grep<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-\\>", ":<C-U>TmuxNavigatePrevious<CR>", { noremap = true, silent = true })

vim.cmd([[
  :command W w
  :command Wq wq
  :command Qa qa
  :command QA qa
  :command WQ wq
]])

-----------------------------------------------------
-- LSP
-----------------------------------------------------
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,
})

-----------------------------------------------------
-- Colorscheme
-----------------------------------------------------
vim.cmd([[colorscheme tokyonight]])
