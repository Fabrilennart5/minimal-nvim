-- =============================================
-- Configuración Básica del Editor
-- =============================================

-- ======================
-- 1. Tema de Colores
-- ======================
vim.cmd.colorscheme('gruvbox')  -- Requiere tener instalado el plugin gruvbox.nvim

-- ======================
-- 2. Números de Línea y Cursor
-- ======================
vim.opt.nu = true                -- Muestra números de línea absolutos
vim.opt.relativenumber = true    -- Muestra números de línea relativos
vim.opt.cursorline = true        -- Resalta la línea actual del cursor
vim.opt.colorcolumn = "1000"     -- Columna vertical guía (deshabilitada con valor alto)
vim.opt.scrolloff = 8            -- Mínimo de líneas al hacer scroll
vim.opt.signcolumn = "yes"       -- Columna para marcadores (errores, git, etc.)

-- ======================
-- 3. Configuración de Indentación
-- ======================
vim.opt.tabstop = 2              -- Espacios por tabulación
vim.opt.softtabstop = 2          -- Espacios por tab al editar
vim.opt.shiftwidth = 2           -- Espacios para indentación automática
vim.opt.expandtab = true         -- Convierte tabs en espacios
vim.opt.smartindent = true       -- Indentación inteligente
vim.opt.wrap = false             -- No dividir líneas largas

-- ======================
-- 4. Manejo de Archivos
-- ======================
vim.opt.swapfile = false         -- Desactiva archivos .swp
vim.opt.backup = false           -- Desactiva archivos de respaldo
vim.opt.undofile = true          -- Habilita historial de cambios persistente

-- Configuración específica para sistemas no-Windows
if vim.loop.os_uname().sysname ~= "Windows_NT" then
  vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Directorio para undo persistente
end

-- ======================
-- 5. Comportamiento de Búsqueda
-- ======================
vim.opt.incsearch = true         -- Búsqueda incremental
vim.opt.isfname:append("@-@")    -- Caracteres especiales en nombres de archivo

-- ======================
-- 6. Rendimiento
-- ======================
vim.opt.updatetime = 50          -- Tiempo de actualización para plugins
