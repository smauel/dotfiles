local m = require('mapx').setup({ whichkey = true })

-- autoformat on save
require('lsp-format').setup {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lua_runtime_path = vim.split(package.path, ';')
table.insert(lua_runtime_path, 'lua/?.lua')
table.insert(lua_runtime_path, 'lua/?/init.lua')


local on_attach = function(client)
  require('lsp-format').on_attach(client)

  m.nmap("gd", ":<C-u>Telescope lsp_definitions<CR>", "silent", "Goto Definition")
  m.nmap("gi", ":<C-u>Telescope lsp_implementations<CR>", "silent", "Goto Implementation")
  m.nmap("gr", ":<C-u>Telescope lsp_references<CR>", "silent", "Goto References")
  m.nmap("gj", ":<C-u>Telescope lsp_document_symbols<CR>", "silent", "Document Symbols")

  m.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "silent", "Hover")
  m.nmap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "silent", "Signature Help")

  m.nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "silent", "Code Action")
  m.nnoremap('<leader>cr', "<cmd>lua vim.lsp.buf.rename(<CR>", 'silent', 'Rename')
  m.nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "silent", "Next Diagnostic...")
  m.nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "silent", "Prev Diagnostic...")
  m.nmap("][d", "<cmd>Telescope diagnostics<cr>", "silent", "Diagnostics")

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
    'sumneko_lua',
    'marksman',
    'jsonls',
    'html',
    'golangci_lint_ls',
    'gopls',
    'bashls',
    'angularls',
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

  ['sumneko_lua'] = function(_)
    require('lspconfig').sumneko_lua.setup {
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
