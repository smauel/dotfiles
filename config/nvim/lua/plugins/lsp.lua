return {
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      automatic_setup = true,
      automatic_installation = true,
    },
    config = function(_, opts)
      local mnls = require("mason-null-ls")
      mnls.setup(opts)
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "ThePrimeagen/refactoring.nvim",
    },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.buf,
        null_ls.builtins.code_actions.refactoring,
        null_ls.builtins.code_actions.gitsigns,
      }
      return opts
    end,
  },
}
