local dap = require("dap")            -- Load the main DAP module
local dapui = require("dapui")        -- Load the DAP UI module for better interface
local dap_python = require("dap-python")  -- Load Python-specific DAP adapter

dapui.setup({})                      -- Initialize DAP UI with default settings

require("nvim-dap-virtual-text").setup({
  commented = true,                  -- Show virtual text as comments next to code
})

dap_python.setup("python3")          -- Setup Python DAP adapter using "python3" interpreter

-- Define signs for breakpoints and debugging status with icons and highlights
vim.fn.sign_define("DapBreakpoint", {
  text = "",                      -- Icon for a normal breakpoint
  texthl = "DiagnosticSignError",  -- Use error highlight group
  linehl = "",                     -- No line highlight
  numhl = "",                      -- No number highlight
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "",                      -- Icon for rejected breakpoint
  texthl = "DiagnosticSignError",  -- Use error highlight group
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "",                      -- Icon for current stopped line (arrow)
  texthl = "DiagnosticSignWarn",   -- Warning highlight group
  linehl = "Visual",               -- Highlight the whole line visually
  numhl = "DiagnosticSignWarn",   -- Highlight line number with warning color
})

-- Auto open DAP UI when debugging starts
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

-- Auto close DAP UI when debugging ends or exits
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

local opts = { noremap = true, silent = true }  -- Options for keymaps: non-recursive and silent

-- Keymaps for common debugging commands
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts)  -- Toggle breakpoint
vim.keymap.set("n", "<leader>dc", dap.continue, opts)           -- Continue/Start debugging
vim.keymap.set("n", "<leader>do", dap.step_over, opts)          -- Step over next line
vim.keymap.set("n", "<leader>di", dap.step_into, opts)          -- Step into function
vim.keymap.set("n", "<leader>dO", dap.step_out, opts)           -- Step out of function
vim.keymap.set("n", "<leader>dq", dap.terminate, opts)          -- Terminate debugging session
vim.keymap.set("n", "<leader>du", dapui.toggle, opts)           -- Toggle DAP UI visibility

