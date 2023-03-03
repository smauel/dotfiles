return {
  { "nvim-tree/nvim-web-devicons" },

  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-surround",

  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup()
    end
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "j-hui/fidget.nvim",
      "jayp0521/mason-null-ls.nvim",
      "jose-elias-alvarez/null-ls.nvim",
      "jose-elias-alvarez/typescript.nvim",
      "lukas-reineke/lsp-format.nvim",
      "ray-x/go.nvim",
      "williamboman/mason-lspconfig.nvim",
      "williamboman/mason.nvim",
    },
    config = function()
      require("smauel.config.lsp")
    end
  },

  {
    "folke/trouble.nvim",
    opts = {},
    keys = {
      { "<leader>d", ":TroubleToggle<CR>", desc = "Trouble Diagnostics" }
    }
  },

  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    }
  },

  {
    "windwp/nvim-autopairs",
    opts = {
      disable_filetype = { "TelescopePrompt" },
    }
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
}
