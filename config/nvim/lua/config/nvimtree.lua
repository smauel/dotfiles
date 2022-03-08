require("nvim-tree").setup({
	disable_netrw = false,
	auto_close = true,
	git = {
		ignore = true,
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
})
