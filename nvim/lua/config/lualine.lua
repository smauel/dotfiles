require('lualine').setup {
    options = {theme = 'everforest', icons_enabled = false, section_separators = {'', ''}},
    sections = {
        lualine_a = {{'mode', lower = false}},
        lualine_b = {{'branch', color = {gui = 'bold'}}},
        lualine_c = {{'filename', color = {gui = 'italic'}}},
        lualine_x = {'filetype'},
        lualine_y = {'g:coc_status'},
        lualine_z = {'location'}
    }
}
