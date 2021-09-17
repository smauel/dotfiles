require('lualine').setup {
  options = {theme = 'nord', icons_enabled = false, section_separators = {'', ''}},
  sections = {
    lualine_a = {{'mode', lower = false}},
    lualine_b = {{'branch', color = {gui = 'bold'}}},
    lualine_c = {{'filename', color = {gui = 'italic'}}},
    lualine_x = {
      {
        'diagnostics',
        sources = {'coc'},
        sections = {'error', 'warn', 'info'},
        symbols = { error = '✘ ', warn = ' ', info = ' '},
        color_error = '#bf616a',
        color_warn = '#d08770',
        color_info = '#ebcb8b',
      },
    },
    lualine_y = {'filetype'},
    lualine_z = {'location'}
  }
}
