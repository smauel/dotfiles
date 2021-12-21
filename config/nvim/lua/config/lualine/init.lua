local components = require('config.lualine.components')

local default_options = {
  icons_enabled = true,
  component_separators = { left = "", right = "" },
  section_separators = { left = "", right = "" },
  disabled_filetypes = { 'NvimTree' },
}

require('lualine').setup {
  options = default_options,
  sections = {
    lualine_a = {
      components.mode
    },
    lualine_b = {
      components.branch,
      components.filename
    },
    lualine_c = {
      components.diff
    },
    lualine_x = {
      components.diagnostics,
      components.treesitter,
      components.lsp,
      components.filetype
    },
    lualine_y = {},
    lualine_z = {
      components.progress
    }
  }
}

