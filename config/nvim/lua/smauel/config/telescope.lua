local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },

    vimgrep_arguments = {
      "rg",
      "--hidden",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
    },
  },

  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
      }
    }
  }
})

require("telescope").load_extension("ui-select")
-- require("telescope").load_extension("fzf")

local M = {}
M.find_files = function()
  telescope_builtin.find_files({ hidden = true })
end

M.find_config_files = function()
  local config_dir = vim.env.HOME .. "/src/dotfiles"
  telescope_builtin.find_files({
    prompt_title = "Dotfiles",
    previewer = false,
    find_command = {
      "rg",
      "--files",
      "--iglob",
      "!.git",
      "--hidden",
      config_dir,
    },
  })
end

M.live_grep = function()
  telescope_builtin.live_grep({})
end

M.file_browser = function()
  telescope_builtin.file_browser({})
end

M.buffers = function()
  telescope_builtin.buffers({ previewer = false })
end

M.git_commits = function()
  telescope_builtin.git_commits({})
end

M.git_files = function()
  telescope_builtin.git_files({})
end

M.git_branches = function()
  telescope_builtin.git_branches({})
end

M.command_history = function()
  telescope_builtin.command_history({})
end

M.keymaps = function()
  telescope_builtin.keymaps({})
end

M.quickfix = function()
  telescope_builtin.quickfix({})
end

M.colorscheme = function()
  telescope_builtin.colorscheme({})
end

M.lsp_workspace_symbols = function()
  telescope_builtin.lsp_workspace_symbols({})
end

M.diagnostics = function()
  telescope_builtin.diagnostics({})
end

M.lsp_references = function()
  telescope_builtin.lsp_references({
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  })
end

M.lsp_implementations = function()
  telescope_builtin.lsp_implementations({
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = "top",
    },
    sorting_strategy = "ascending",
    ignore_filename = false,
  })
end

M.lsp_code_actions = function()
  local opts = telescope_themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  telescope_builtin.lsp_code_actions(opts)
end

M.git_status = function()
  telescope_builtin.git_status()
end

M.oldfiles = function()
  telescope_builtin.oldfiles()
end

return M
