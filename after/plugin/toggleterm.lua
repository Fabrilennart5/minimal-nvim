require("toggleterm").setup({
  size = 20, -- terminal height (for horizontal) or width (for vertical)
  open_mapping = nil, -- no default mapping, we define our own
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  persist_size = true,
  direction = "horizontal", 
  close_on_exit = true,
  shell = vim.o.shell, -- use Neovim's default shell
})

-- Keymaps for opening and closing the terminal
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle horizontal terminal" })
vim.keymap.set("t", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle horizontal terminal from terminal mode" })

