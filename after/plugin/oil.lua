-- Configuración de Oil con iconos
require("oil").setup({
  columns = { "icon" },
})

vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open Oil explorer" })


