return {
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>cx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Trouble: [C]ode Diagnostics",
      },
      {
        "<leader>cX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Trouble [C]ode Buffer Diagnostics",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Trouble: [C]ode [S]ymbols",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "Trouble: [C]ode [L]SP",
      },
      {
        "<leader>cL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Trouble: [C]ode [L]ocation List",
      },
      {
        "<leader>cQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Trouble: [C]ode [Q]uickfix List",
      },
    },
  },
}
