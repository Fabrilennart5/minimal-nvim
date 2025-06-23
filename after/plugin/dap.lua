local dap = require("dap")
local dap_python = require("dap-python")
local dapui = require("dapui")

-- Setup dap-python with python3
dap_python.setup("python3")

-- Setup dap-ui
dapui.setup({
  icons = { expanded = "▾", collapsed = "▸", current_frame = "▶" },
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
        { id = "watches", size = 0.25 },
      },
      position = "left",
      size = 40,
    },
    {
      elements = {
        { id = "repl", size = 0.5 },
        { id = "console", size = 0.5 },
      },
      position = "bottom",
      size = 10,
    },
  },
  controls = { enabled = true, element = "repl" },
})

-- Setup virtual text for debugging values
require("nvim-dap-virtual-text").setup({
  commented = true,
  enabled = true,
})

-- Define breakpoint signs with icons
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticSignWarn", linehl = "Visual", numhl = "DiagnosticSignWarn" })

-- Listeners to auto open/close dap-ui
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- Minimal keymaps for debugging
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)
vim.keymap.set("n", "<leader>dc", dap.continue, opts)
vim.keymap.set("n", "<leader>do", dap.step_over, opts)
vim.keymap.set("n", "<leader>di", dap.step_into, opts)
vim.keymap.set("n", "<leader>dO", dap.step_out, opts)
vim.keymap.set("n", "<leader>dq", dap.terminate, opts)
vim.keymap.set("n", "<leader>du", dapui.toggle, opts)

