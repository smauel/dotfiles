local currentmod = (...)
local M = {}

local function add(modname)
  local modulepath = string.format('%s.%s', currentmod, modname)
  local success, results = pcall(require, modulepath)
  if not success then
    vim.api.nvim_err_writeln(results)
    return
  end

  return results
end

M.init = function()
end

M.setup = function()
  add 'lsp'
  add 'telescope'
  add 'lualine'
  add 'compe'
  add 'lspsaga'
  add 'treesitter'
  add 'lspkind'
  add 'autopairs'
  add 'gitsigns'
end

return M
