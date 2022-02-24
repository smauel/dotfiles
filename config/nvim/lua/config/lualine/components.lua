local conditions = require("config.lualine.conditions")
local colors = require("config.lualine.colors")
local nvim_status = require("lsp-status")

local function diff_source()
	local gitsigns = vim.b.gitsigns_status_dict
	if gitsigns then
		return {
			added = gitsigns.added,
			modified = gitsigns.changed,
			removed = gitsigns.removed,
		}
	end
end

return {
	mode = {
		"mode",
		color = {},
		cond = nil,
	},

	branch = {
		"b:gitsigns_head",
		icon = " ",
		color = { gui = "bold" },
		cond = conditions.hide_in_width,
	},

	filename = {
		"filename",
		color = {},
		cond = nil,
	},

	filetype = {
		"filetype",
		color = {},
		icon = nil,
		cond = nil,
	},

	progress = {
		"progress",
		color = {},
		cond = nil,
	},

	diff = {
		"diff",
		source = diff_source,
		symbols = { added = "  ", modified = "~", removed = " " },
		diff_color = {
			added = { fg = colors.green },
			modified = { fg = colors.yellow },
			removed = { fg = colors.red },
		},
		color = {},
		cond = nil,
	},

	diagnostics = {
		"diagnostics",
		sources = { "nvim_lsp", "nvim_diagnostic" },
		sections = { "error", "warn", "info", "hint" },
		symbols = { error = " ", warn = " ", info = " ", hint = " " },
		diagnostics_color = {
			error = { fg = colors.red },
			warn = { fg = colors.orange },
			info = { fg = colors.yellow },
			hint = { fg = colors.blue },
		},
		colored = true,
	},

	treesitter = {
		function()
			local b = vim.api.nvim_get_current_buf()
			if next(vim.treesitter.highlighter.active[b]) then
				return "  "
			end
			return ""
		end,
		color = { fg = colors.green },
		cond = conditions.hide_in_width,
	},

	lsp = {
		function()
			local b = nvim_status.status()
			return b
		end,
		icon = nil,
		color = { gui = "bold" },
	},
}
