local Util = require("lazyvim.util")

return {
  { "christoomey/vim-tmux-navigator", lazy = false },

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, og)
      return vim.tbl_deep_extend("force", og, {
        sources = {
          "filesystem",
          "document_symbols",
        },
        close_if_last_window = true,
      })
    end,
    keys = {
      {
        "<leader>l",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
        end,
        desc = "Explorer NeoTree (root dir)",
      },
      {
        "<leader>L",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>o",
        function()
          require("neo-tree.command").execute({ toggle = true, source = "document_symbols" })
        end,
        desc = "Symbols Outline",
      },
    },
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      {
        "<leader>p",
        Util.telescope("files"),
        desc = "Find Files (root dir)",
      },
    },
  },
}
