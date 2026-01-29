return {
  "folke/snacks.nvim",
  opts = {
    explorer = {},
    picker = {
      hidden = true,
      sources = {
        explorer = {},
      },
    },
  },
  keys = {
    {
      "<leader>l",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer",
    },
    {
      "<leader>p",
      function()
        Snacks.picker.files({ hidden = true })
      end,
      desc = "Find Files",
    },
    {
      "<leader>r",
      function()
        Snacks.picker.grep({ finder = "grep" })
      end,
      desc = "Find Files",
    },
  },
}
