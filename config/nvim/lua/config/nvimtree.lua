require("nvim-tree").setup({
	disable_netrw = false,
	git = {
		ignore = true,
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
})

-- autoclose tab/vim when nvimtree is the last window in the tab
vim.api.nvim_command([[
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif
]])
