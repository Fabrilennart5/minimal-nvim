-- Personalization for oil
require("oil").setup({
  default_file_explorer = true,
  columns = { "icon" },  -- Solo iconos, nada más

  keymaps = {
    ["<leader>o"] = function() vim.cmd("Oil") end,
    ["<CR>"] = "actions.select",
    ["-"] = "actions.parent",
  },
  use_default_keymaps = false,
})

vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", { desc = "Open Oil explorer" })


