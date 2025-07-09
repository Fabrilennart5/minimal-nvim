require("toggleterm").setup({
  -- Configuración para terminal vertical
  size = function(term)
    if term.direction == "vertical" then
      return vim.o.columns * 0.4  -- 40% del ancho de la ventana
    end
    return 20  -- Tamaño por defecto para otras direcciones
  end,
  direction = "vertical",  -- Dirección por defecto: vertical
  open_mapping = nil,      -- Mantenemos tus mapeos personalizados
  
  -- Configuración específica para terminales verticales
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  persist_size = true,
  close_on_exit = true,
  shell = vim.o.shell,

  -- Opciones visuales
  highlights = {
    -- Personaliza los colores del borde si lo deseas
    FloatBorder = {
      guifg = "#3E4452",
    }
  }
})

-- Mapeos existentes (se mantienen igual pero ahora abrirán terminal vertical)
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm direction=vertical<CR>", { 
  desc = "Toggle terminal vertical" 
})

vim.keymap.set("t", "<leader>t", "<cmd>ToggleTerm direction=vertical<CR>", {
  desc = "Toggle terminal vertical desde modo terminal"
})

-- Mapeo adicional opcional para terminal horizontal
vim.keymap.set("n", "<leader>T", "<cmd>ToggleTerm direction=horizontal<CR>", {
  desc = "Toggle terminal horizontal"
})
