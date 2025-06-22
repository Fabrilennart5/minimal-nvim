-- My Oil config
-- Oil is my favorite way of navigating in neovim

require("oil").setup({
  -- Configuración básica
  default_file_explorer = true,
  columns = { "icon" },
  
  -- Keymaps correctos
  keymaps = {
    ["<leader>o"] = function() vim.cmd("Oil") end,  -- Esta es la forma correcta
    ["<CR>"] = "actions.select",
    ["-"] = "actions.parent",
  },
  use_default_keymaps = false,
})

-- Versión alternativa igualmente válida:
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open Oil explorer" })
