local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
	return
end

local nvim_status = require("lsp-status")
local m = require("mapx").setup({ global = "force", whichkey = true })

local ts = require("config.telescope")
local handlers = require("lsp.handlers")

local status = require("lsp.status")
status.activate()

local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.formatting.stylua,
	null_ls.builtins.formatting.eslint_d,
	null_ls.builtins.formatting.prettier,
}
null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			print("in formatting")
			vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
            augroup END
            ]])
		end
	end,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local filetype_attach = setmetatable({}, {
	__index = function()
		return function() end
	end,
})

local custom_init = function(client)
	client.config.flags = client.config.flags or {}
	client.config.flags.allow_incremental_sync = true
end

local custom_attach = function(client)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")

	nvim_status.on_attach(client)

	m.nnoremap("K", vim.lsp.buf.hover, "silent", "Docs")
	m.nnoremap("gd", vim.lsp.buf.definition, "silent", "Go to definition")
	m.nnoremap("gD", vim.lsp.buf.declaration, "silent", "Go to declaration")
	m.nnoremap("gi", ts.lsp_implementations, "silent", "Go to implementation")
	m.nnoremap("gI", handlers.implementation, "silent", "Go to implementation")
	m.nnoremap("gn", ":lua vim.diagnostic.goto_next()<CR>", "silent", "Go to next diagnostic")
	m.nnoremap("gp", ":lua vim.diagnostic.goto_prev()<CR>", "silent", "Go to previous diagnostic")
	m.nnoremap("gr", ts.lsp_references, "silent", "References")
	m.nnoremap("gs", vim.lsp.buf.signature_help, "silent", "Signature help")
	m.nnoremap("<space>a", ts.lsp_code_actions, "silent", "References")

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Set autocommands conditional on server_capabilities
	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
	end

	if client.resolved_capabilities.code_lens then
		vim.cmd([[
      augroup lsp_document_codelens
        au! * <buffer>
        autocmd BufEnter ++once         <buffer> lua require"vim.lsp.codelens".refresh()
        autocmd BufWritePost,CursorHold <buffer> lua require"vim.lsp.codelens".refresh()
      augroup END
    ]])
	end

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities.textDocument.codeLens = { dynamicRegistration = false }
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local servers = {
	html = true,
	vimls = true,
	yamlls = true,
	eslint = true,
	tsserver = {
		cmd = { "typescript-language-server", "--stdio" },
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},
	},
	sumneko_lua = {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
}

local setup_server = function(server, config)
	if not config then
		return
	end

	if type(config) ~= "table" then
		config = {}
	end

	config = vim.tbl_deep_extend("force", {
		on_init = custom_init,
		on_attach = custom_attach,
		capabilities = updated_capabilities,
		flags = {
			debounce_text_changes = nil,
		},
	}, config)

	lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
	setup_server(server, config)
end

return {
	on_init = custom_init,
	on_attach = custom_attach,
	capabilities = updated_capabilities,
}
