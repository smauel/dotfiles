return {
  "folke/tokyonight.nvim",
  "navarasu/onedark.nvim",
  "arturgoms/moonbow.nvim",

  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      vim.cmd.colorscheme "catppuccin-mocha"
    end
  },

}
