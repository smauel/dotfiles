local colors = {
    nord1 = '#3B4252',
    nord3 = '#4C566A',
    nord5 = '#E5E9F0',
    nord6 = '#ECEFF4',
    nord7 = '#8FBCBB',
    nord8 = '#88C0D0',
    nord13 = '#EBCB8B',
    nord14 = '#bf616a'
}

local custom_nord = require 'lualine.themes.nord'
custom_nord.normal.a = {bg = colors.nord1, fg = colors.nord13, gui = 'bold'}
custom_nord.insert.a = {bg = colors.nord1, fg = colors.nord13, gui = 'bold'}
custom_nord.visual.a = {bg = colors.nord1, fg = colors.nord13, gui = 'bold'}
custom_nord.replace.a = {bg = colors.nord1, fg = colors.nord13, gui = 'bold'}

require('lualine').setup {
    options = {theme = 'nord', icons_enabled = false, section_separators = {'', ''}},
    sections = {
        lualine_a = {{'mode', lower = false}},
        lualine_b = {{'branch', color = {bg = colors.nord14, fg = colors.nord5, gui = 'bold'}}},
        lualine_c = {{'filename', color = {bg = colors.nord3, fg = colors.nord5, gui = 'italic'}}},
        lualine_x = {'filetype', require'lsp-status'.status},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    }
}

