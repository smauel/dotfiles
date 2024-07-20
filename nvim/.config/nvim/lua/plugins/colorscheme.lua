return {
  {
    "catppuccin/nvim",
    event = "VeryLazy",
    name = "catppuccin",
    keys = {
      {
        "<leader>uu",
        function()
          if vim.g.colors_name == "catppuccin-mocha" then
            vim.cmd("colorscheme catppuccin-latte")
          else
            vim.cmd("colorscheme catppuccin-mocha")
          end
        end,
        desc = "Toggle catppuccin dark mode",
      },
    },
  },

  -- load colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
    },
  },
}
