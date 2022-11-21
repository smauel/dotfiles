local deps_ok, js_debug, dap, dapui = pcall(function()
  return require "dap-vscode-js", require "dap", require "dapui"
end)
if not deps_ok then
  return
end

local m = require("mapx").setup({ whichkey = true })
dapui.setup()

-- Debug Keymappings
m.nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<CR>", "silent", "Continue")
m.nnoremap("<leader>do", "<cmd>lua require'dap'.step_over()<CR>", "silent", "Step Over")
m.nnoremap("<leader>di", "<cmd>lua require'dap'.step_into()<CR>", "silent", "Step Into")
m.nnoremap("<leader>du", "<cmd>lua require'dap'.step_out()<CR>", "silent", "Step Out")
m.nnoremap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "silent", "Toggle Breakpoint")
m.nnoremap("<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", "silent",
  "Set Breakpoint Condition")
m.nnoremap("<leader>dt", "<cmd>lua require'jester'.debug()<CR>", "silent", "Debug Test")

-- Open/Close dap-ui automatically
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

js_debug.setup {
  debugger_cmd = { "js-debug-adapter" },
  adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
}

for _, language in ipairs { "typescript", "javascript" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "[pwa-node] Launch file",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "attach",
      name = "[pwa-node] Attach",
      processId = require("dap.utils").pick_process,
      cwd = "${workspaceFolder}",
    },
    {
      type = "pwa-node",
      request = "launch",
      name = "Debug Jest Tests",
      -- trace = true, -- include debugger info
      runtimeExecutable = "node",
      runtimeArgs = {
        "./node_modules/jest/bin/jest.js",
        "--runInBand",
      },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end
