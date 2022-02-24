require("nvim-treesitter.configs").setup({
	ensure_installed = { "javascript", "typescript", "lua" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})
