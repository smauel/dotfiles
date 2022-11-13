local components = require("config.lualine.components")

local default_options = {
  icons_enabled = true,
  component_separators = { left = "", right = "" },
  section_separators = { left = "", right = "" },
  disabled_filetypes = { "NvimTree" },
  --   theme = "gruvbox",
}

require("lualine").setup({
  options = default_options,
  sections = {
    lualine_a = {
      components.mode,
    },
    lualine_b = {
      components.branch,
      components.filename,
    },
    lualine_c = {
      components.diagnostics,
    },
    lualine_x = {
      components.diff,
      components.lsp,
    },
    lualine_y = {
      components.treesitter,
      components.filetype,
    },
    lualine_z = {
      components.progress,
    },
  },
})
