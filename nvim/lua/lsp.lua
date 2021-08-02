local lsp_status = require('lsp-status')
local lsp_config = require('lspconfig')

lsp_status.register_progress()

-- tsserver
lsp_config.tsserver.setup {onattach = lsp_status.onattach, capabilities = lsp_status.capabilities}
vim.cmd('autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)')

-- lua
local sumneko_root_path = vim.fn.stdpath('data') .. '/lspinstall/lua'
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

lsp_config.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = runtime_path},
            diagnostics = {globals = {'vim'}},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            telemetry = {enable = false}
        }
    },
    onattach = lsp_status.onattach,
    capabilities = lsp_status.capabilities
}
vim.cmd('autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 100)')

-- efm
lsp_config.efm.setup {
    init_options = {documentFormatting = true},
    filetypes = {"lua"},
    settings = {
        rootMarkers = {".git/"},
        languages = {
            lua = {
                {
                    formatCommand = "lua-format -i --no-keep-simple-function-one-line --no-break-after-operator --column-limit=150 --break-after-table-lb",
                    formatStdin = true
                }
            }
        }
    },
    onattach = lsp_status.onattach,
    capabilities = lsp_status.capabilities
}

