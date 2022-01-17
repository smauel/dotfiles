require'nvim-treesitter.configs'.setup {
  ensure_installed = { "javascript", "java", "scala", "typescript" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
}
