return {
  "christoomey/vim-tmux-navigator",
  lazy = false,
  keys = {
    { "<C-h>", ":<C-U>TmuxNavigateLeft<CR>", desc = "Move Left" },
    { "<C-l>", ":<C-U>TmuxNavigateRight<CR>", desc = "Move Right" },
    { "<C-j>", ":<C-U>TmuxNavigateDown<CR>", desc = "Move Down" },
    { "<C-k>", ":<C-U>TmuxNavigateUp<CR>", desc = "Move Up" },
    { "<C-\\>", ":<C-U>TmuxNavigatePrevious<CR>", desc = "Move Previous" },
  },
}
