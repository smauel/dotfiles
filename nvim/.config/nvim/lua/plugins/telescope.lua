local Util = require("lazyvim.util")

return {
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
        Util.telescope("files"),
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
