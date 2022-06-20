-- ensure packer is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd("packadd packer.nvim")
end

-- auto compile when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
	function(use)
		use("wbthomason/packer.nvim")
		use("editorconfig/editorconfig-vim")
		use("tpope/vim-surround")

		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.nvimtree")
			end,
		})

		use({
			"b0o/mapx.nvim",
			requires = { "folke/which-key.nvim" },
		})

		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
			config = function()
				require("config.treesitter")
			end,
		})

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
        { 'fannheyward/telescope-coc.nvim' },
        { 'LinArcX/telescope-env.nvim'}
			},
			config = function()
				require("config.telescope")
			end,
		})

		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("gitsigns").setup()
			end,
		})

		use({
			"hoob3rt/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("config.lualine")
			end,
		})

		use({
			"neoclide/coc.nvim",
			branch = "release",
			requires = { "honza/vim-snippets", opt = true },
			config = function()
				require("config.coc")
			end,
		})

		use({
			"windwp/nvim-autopairs",
			config = function()
				require("config.autopairs")
			end,
		})

		use("alvan/vim-closetag")

		use("mattn/emmet-vim")

		-- colorschemes
		use("ellisonleao/gruvbox.nvim")
    use("marko-cerovac/material.nvim")
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
