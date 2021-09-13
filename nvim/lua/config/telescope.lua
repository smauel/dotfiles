local telescope = require 'telescope'
local telescope_builtin = require 'telescope.builtin'
local actions = require 'telescope.actions'

telescope.setup {
    defaults = {
        layout_config = {prompt_position = 'top'},
        sorting_strategy = 'ascending',

        mappings = {i = {["<esc>"] = actions.close}},

        vimgrep_arguments = {'rg', '--hidden', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'},

        extensions = {fzy_native = {override_generic_sorter = false, override_file_sorter = true}}
    }
}

telescope.load_extension('fzy_native')
telescope.load_extension('coc')

local M = {}
M.find_files = function()
    telescope_builtin.find_files {}
end

M.find_config_files = function()
    local config_dir = vim.env.HOME .. '/dev/dotfiles'
    telescope_builtin.find_files {find_command = {'rg', '--files', '--iglob', '!.git', '--hidden', config_dir}}
end

M.live_grep = function()
    telescope_builtin.live_grep {}
end

M.file_browser = function()
    telescope_builtin.file_browser {}
end

M.buffers = function()
    telescope_builtin.buffers {previewer = false}
end

M.commits = function()
    telescope_builtin.git_commits {}
end

M.git_files = function()
    telescope_builtin.git_files {}
end

M.quickfix = function()
    telescope_builtin.quickfix {}
end

M.colorscheme = function()
    telescope_builtin.colorscheme {}
end

return M
