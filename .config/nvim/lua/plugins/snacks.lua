return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>l",
      function()
        Snacks.explorer({ cwd = LazyVim.root() })
      end,
      desc = "Explorer Snacks (root dir)",
    },
    {
      "<leader>L",
      function()
        Snacks.explorer()
      end,
      desc = "Explorer Snacks (cwd)",
    },
    { "<leader>r", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
    { "<leader>R", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
    { "<leader>p", LazyVim.pick("files"), desc = "Find Files (Root Dir)" },
    { "<leader>P", LazyVim.pick("files", { root = false }), desc = "Find Files (cwd)" },
  },
}
