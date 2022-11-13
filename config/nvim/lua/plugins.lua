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
    -- General
    use "wbthomason/packer.nvim"
    use "tpope/vim-surround"

    -- Colorscheme
    use { "catppuccin/nvim", as = "catppuccin" }

    -- TreeSitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter")
      end,
    }

    -- NvimTree
    use({
      "kyazdani42/nvim-tree.lua",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("config.nvimtree")
      end,
    })

    -- Telescope
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope-ui-select.nvim" },
      },
      config = function()
        require("config.telescope")
      end,
    }

    -- Git
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("gitsigns").setup()
      end,
    }

    -- LSP
    use {
      "williamboman/mason.nvim",
      requires = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-null-ls.nvim",
        "lukas-reineke/lsp-format.nvim",
        "onsails/lspkind.nvim",
        "jose-elias-alvarez/typescript.nvim",
      }
    }
    use({
      "glepnir/lspsaga.nvim",
      branch = "main",
      config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
          diagnostic_header = { " ", " ", " ", "ﴞ " },
          code_action_lightbulb = {
            enable = false
          },
          code_action_keys = {
            quit = '<ESC>',
          },
          definition_action_keys = {
            quit = '<ESC>',
          },
          rename_action_quit = '<ESC>',
        })
      end,
    })

    -- Keymappings
    use {
      "b0o/mapx.nvim",
      requires = { "folke/which-key.nvim" },
    }

    -- Autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip"
      },
      config = function()
        require("config.cmp")
      end
    }

    -- AutoPairs
    use({
      "windwp/nvim-autopairs",
      config = function()
        require("config.autopairs")
      end,
    })

    -- StatusLine
    use({
      "hoob3rt/lualine.nvim",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = function()
        require("config.lualine")
      end,
    })

    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {}
      end
    }
  end,

  config = {
    display = {
      open_fn = function()
        return require("packer.util").float({ border = "single" })
      end,
    },
  },
})
