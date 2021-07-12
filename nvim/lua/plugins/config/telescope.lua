local telescope = require 'telescope'
local telescope_builtin = require 'telescope.builtin'
local telescope_actions = require 'telescope.actions'
local M = {}

telescope.setup {
  defaults = {
    layout_strategy = 'horizontal',
    layout_config = {
      prompt_position = 'top',
    },
    sorting_strategy = 'ascending',
    use_less = false,
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
  }
}

M.find_files = function()
  telescope_builtin.find_files {
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden' },
    previewer = false
  }
end

M.find_config_files = function()
  local config_dir = vim.env.HOME .. '/dev/dotfiles'
  telescope_builtin.find_files {
    find_command = { 'rg', '--files', '--iglob', '!.git', '--hidden', config_dir },
    previewer = false
  }
end

M.live_grep = function()
  telescope_builtin.live_grep {}
end

M.file_browser = function()
  telescope_builtin.file_browser {}
end

M.buffers = function()
  telescope_builtin.buffers {
    previewer = false
  }
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

return M
