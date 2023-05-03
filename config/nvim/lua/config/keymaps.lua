-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- tmux navigator
vim.keymap.set("n", "<C-h>", ":<C-U>TmuxNavigateLeft<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", ":<C-U>TmuxNavigateRight<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", ":<C-U>TmuxNavigateDown<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", ":<C-U>TmuxNavigateUp<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-\\>", ":<C-U>TmuxNavigatePrevious<cr>", { noremap = true, silent = true })

-- toggle background
vim.keymap.set("n", "<leader>ub", function()
  local background = vim.opt.background["_value"]
  if background == "dark" then
    print("Switching to light mode")
    vim.opt.background = "light"
  elseif background == "light" or background == "" then
    print("Switching to dark mode")
    vim.opt.background = "dark"
  else
    print("custom `background` set, can't switch modes")
  end
end, { desc = "Toggle [b]ackground (dark/light)" })
