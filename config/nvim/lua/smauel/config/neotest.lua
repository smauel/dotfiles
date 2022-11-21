require("neotest").setup({
  adapters = {
    require("neotest-jest")({
      jestCommand = "yarn test --",
      jestConfigFile = "jest.config.ts",
      cwd = function(path)
        return vim.fn.getcwd()
      end
    })
  },
  icons = {
    passed = "✓",
    running = "…",
    failed = "❌",
    skipped = "--",
    unknown = "~",
  }
})
