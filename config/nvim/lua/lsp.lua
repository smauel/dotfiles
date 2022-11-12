local m = require("mapx").setup({ whichkey = true })
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local mason = require("mason")
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",
    "yamlls",
    "volar",
    "terraformls",
    "sqlls",
    "sumneko_lua",
    "marksman",
    "jsonls",
    "html",
    "golangci_lint_ls",
    "gopls",
    "bashls",
    "angularls",
  }
})

local on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client)

  -- Keymappings
	m.nmap("<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", "silent", "Type Definition")

  m.nmap("gd", ":<C-u>Telescope lsp_definitions<CR>", "silent", "Goto Definition")
  m.nmap("gi", ":<C-u>Telescope lsp_implementations<CR>", "silent", "Goto Implementation")
  m.nmap("gr", ":<C-u>Telescope lsp_references<CR>", "silent", "Goto References")
  m.nmap("gj", ":<C-u>Telescope lsp_document_symbols<CR>", "silent", "Document Symbols")
	m.nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "silent", "Hover")
	m.nmap("<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "silent", "Signature Help")

	m.nmap("<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", "silent", "Code Action")
  m.nnoremap('<leader>cr', "<cmd>lua vim.lsp.buf.rename()<CR>", 'silent', 'Rename')
	m.nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "silent", "Next Diagnostic...")
	m.nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "silent", "Prev Diagnostic...")
	m.nmap("][d", "<cmd>Telescope diagnostics<cr>", "silent", "Diagnostics")

	if client.server_capabilities.document_formatting then
		vim.cmd([[
			augroup formatting
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
			augroup END
		]])
	end

	-- Set autocommands conditional on server_capabilities
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

require("mason-lspconfig").setup_handlers {
  -- default handler.
  function (server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach
    }
  end,

  -- specific servers.
  ["sumneko_lua"] = function ()
    require("lspconfig").sumneko_lua.setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    }
  end
}

require("null-ls").setup()
require("mason-null-ls").setup({ automatic_setup = true })
require 'mason-null-ls'.setup_handlers()
