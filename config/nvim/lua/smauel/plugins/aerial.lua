return {
  {
    "stevearc/aerial.nvim",
    keys = {
      {
        "<leader>o",
        function()
          -- only ever show neotree or aerial
          require("neo-tree").close_all()
          require("aerial").toggle()
        end,
        desc = "Toggle Code Outline",
      },
    },
    opts = {
      layout = {
        default_direction = "left",
        min_width = "40"
      },
    },
  },
}
