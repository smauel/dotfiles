-- autoformat on save
require('lsp-format').setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')

local function diagnostic_goto(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

local on_attach = function(client, bufnr)
  require('lsp-format').on_attach(client)

  local function nmap(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, { silent = true, buffer = bufnr, desc = desc })
  end

  nmap("gd", ":<C-u>Telescope lsp_definitions<CR>", "Goto Definition")
  nmap("gi", ":<C-u>Telescope lsp_implementations<CR>", "Goto Implementation")
  nmap("gr", ":<C-u>Telescope lsp_references<CR>", "Goto References")
  nmap("gj", ":<C-u>Telescope lsp_document_symbols<CR>", "Document Symbols")

  nmap("K", vim.lsp.buf.hover, "Hover")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Help")

  nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
  nmap('<leader>cr', vim.lsp.buf.rename, 'Code Rename')

  nmap("]d", diagnostic_goto(true), "Next Diagnostic...")
  nmap("[d", diagnostic_goto(false), "Prev Diagnostic...")
  nmap("]e", diagnostic_goto(true, "ERROR"), "Next Error...")
  nmap("[e", diagnostic_goto(false, "ERROR"), "Prev Error...")
  nmap("]w", diagnostic_goto(true, "WARN"), "Next Warning...")
  nmap("[w", diagnostic_goto(false, "WARN"), "Prev Warning...")
  nmap("][d", "<cmd>Telescope diagnostics<cr>", "Diagnostics")

  if client.server_capabilities.document_highlight then
    vim.cmd([[
      augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
      ]])
  end
end

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = {
    'tsserver',
    'yamlls',
    'volar',
    'terraformls',
    'sqlls',
    'lua_ls',
    'marksman',
    'jsonls',
    'html',
    'golangci_lint_ls',
    'gopls',
    'bashls',
  }
})

require('mason-lspconfig').setup_handlers {
  -- default handler
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end,

  -- specific servers.
      ['tsserver'] = function(_)
    require('typescript').setup({
      disable_commands = false,
      debug = false,
      go_to_source_definition = {
        fallback = true,
      },
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
      }
    })
  end,

      ['lua_ls'] = function(_)
    require('lspconfig').lua_ls.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
            path = lua_runtime_path,
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        }
      }
    }
  end
}

local signs = {
  Error = " ",
  Warn = " ",
  Hint = " ",
  Info = " "
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- external linters/formatters
require('mason-null-ls').setup({ automatic_setup = true })
require 'mason-null-ls'.setup_handlers {}
require('null-ls').setup({
  sources = {
    require('typescript.extensions.null-ls.code-actions'),
  }
})

-- lsp status information
require('fidget').setup()
