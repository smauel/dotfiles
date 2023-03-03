local colors = { green = "#98be65", red = "#ec5f67", }

local function hide_in_width()
  local window_width_limit = 70
  return vim.fn.winwidth(0) > window_width_limit
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function list_registered_sources(filetype)
  local s = require "null-ls.sources"
  local available_sources = s.get_available(filetype)
  local registered = {}
  for _, source in ipairs(available_sources) do
    for method in pairs(source.methods) do
      registered[method] = registered[method] or {}
      table.insert(registered[method], source.name)
    end
  end
  return registered
end

local components = {
  mode = {
    "mode",
    color = {},
    cond = nil,
  },
  branch = {
    "b:gitsigns_head",
    icon = " ",
    color = { gui = "bold" },
    cond = hide_in_width,
  },
  filename = {
    "filename",
    color = {},
    cond = nil,
  },
  filetype = {
    "filetype",
    icon = nil,
    cond = nil,
  },
  progress = {
    "progress",
    color = {},
    cond = nil,
  },
  diff = {
    "diff",
    source = diff_source,
    padding = { left = 2, right = 1 },
    cond = nil,
  },
  diagnostics = {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    sections = { 'error', 'warn', 'info', 'hint' },
    colored = true,
  },
  treesitter = {
    function()
      return "  "
    end,
    color = function()
      local buf = vim.api.nvim_get_current_buf()
      local ts = vim.treesitter.highlighter.active[buf]
      return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red }
    end,
    cond = hide_in_width,
  },
  lsp = {
    function(msg)
      msg = msg or "LS Inactive"
      local buf_clients = vim.lsp.buf_get_clients()
      if next(buf_clients) == nil then
        -- TODO: clean up this if statement
        if type(msg) == "boolean" or #msg == 0 then
          return "LS Inactive"
        end
        return msg
      end
      local buf_ft = vim.bo.filetype
      local buf_client_names = {}

      -- add client
      for _, client in pairs(buf_clients) do
        if client.name ~= "null-ls" then
          table.insert(buf_client_names, client.name)
        end
      end

      -- add formatter
      local supported_formatters = list_registered_sources(buf_ft)[require("null-ls").methods.FORMATTING] or {}
      vim.list_extend(buf_client_names, supported_formatters)

      -- add linter
      local supported_linters = list_registered_sources(buf_ft)[require("null-ls").methods.DIAGNOSTICS] or {}
      vim.list_extend(buf_client_names, supported_linters)

      local unique_client_names = vim.fn.uniq(vim.fn.sort(buf_client_names))
      local language_servers = "[" .. table.concat(unique_client_names, ", ") .. "]"

      return language_servers
    end,
    color = { gui = "bold" },
    cond = hide_in_width,
  },
}

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { 'NvimTree' }
      },
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
    }
  }
}
