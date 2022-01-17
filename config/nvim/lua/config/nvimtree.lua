local g = vim.g

g.nvim_tree_quit_on_open = 1

require'nvim-tree'.setup {
  disable_netrw       = false,
  auto_close          = true,
  git = {
    ignore = true
  }
}
