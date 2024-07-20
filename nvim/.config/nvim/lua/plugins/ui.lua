local Util = require("lazyvim.util")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
    keys = {
      {
        "<leader>l",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").root.get() })
        end,
        desc = "Explorer NeoTree (root dir)",
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
    opts = {
      pickers = {
        live_grep = {
          file_ignore_patterns = { ".git" },
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        find_files = {
          file_ignore_patterns = { ".git" },
          hidden = true,
        },
      },
    },
    keys = {
      {
        "<leader>p",
        Util.pick("files"),
        desc = "Find Files (root dir)",
      },
      {
        "<leader>r",
        function()
          require("telescope.builtin").live_grep()
        end,
      },
    },
  },
}
