return {
  -- treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "go", "gomod", "gosum", "gowork" })
      end
    end,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        golangci_lint_ls = {},
        gopls = {},
      },
      setup = {
        gopls = function(_, opts)
          require("lazyvim.util").on_attach(function(client, _)
            if client.name == "gopls" then
              -- workaround for gopls not supporting semanticTokensProvider
              -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
              if not client.server_capabilities.semanticTokensProvider then
                local semanticTokens = client.config.capabilities.textDocument.semanticTokens
                client.server_capabilities.semanticTokensProvider = {
                  full = true,
                  legend = {
                    tokenTypes = semanticTokens.tokenTypes,
                    tokenModifiers = semanticTokens.tokenModifiers,
                  },
                  range = true,
                }
              end
            end
          end)
          opts.settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
              semanticTokens = true,
            },
          }
        end,
      },
    },
  },

  -- go.nvim
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
    },
    event = "CmdlineEnter",
    config = function()
      require("go").setup()
    end,
    ft = { "go", "gomod", "gosum", "gowork" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.diagnostics.golangci_lint)
    end,
  },
}
