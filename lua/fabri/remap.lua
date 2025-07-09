-- =============================================
-- Modo de uso:
-- <leader> = Tecla Espacio (se presiona primero)
-- <C-*> = Control + tecla
-- n = Modo Normal | v = Modo Visual | i = Modo Insertar

vim.g.mapleader = " "  -- Configura la tecla líder como Espacio

-- ======================
-- 1. Navegación básica
-- ======================
-- <C-b> en modo Normal: Alternar entre los dos últimos archivos editados
vim.keymap.set("n", "<C-b>", "<C-^>")

-- <C-d>/<C-u> en modo Normal: Desplazamiento vertical manteniendo cursor centrado
vim.keymap.set("n", "<C-d>", "<C-d>zz")  -- Bajar media página
vim.keymap.set("n", "<C-u>", "<C-u>zz")  -- Subir media página

-- n/N en modo Normal: Búsqueda manteniendo cursor centrado
vim.keymap.set("n", "n", "nzzzv")  -- Siguiente resultado de búsqueda
vim.keymap.set("n", "N", "Nzzzv")  -- Resultado anterior de búsqueda

-- ======================
-- 2. Manejo de texto
-- ======================
-- J/K en modo Visual: Mover líneas seleccionadas
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")  -- Mover selección hacia arriba 2 líneas
vim.keymap.set("v", "J", ":m '>+3<CR>gv=gv")  -- Mover selección hacia abajo 3 líneas

-- <leader>p en modo Visual: Pegar sin sobrescribir registro (pegar sobre texto manteniendo copia original)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- <leader>y en modo Normal/Visual: Copiar al portapapeles del sistema (copiar texto para usar fuera de Neovim)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- ======================
-- 3. Comandos útiles
-- ======================
-- <leader>ch en modo Normal: Limpiar resaltado de búsqueda (clear highlight)
vim.keymap.set("n", "<leader>ch", "<cmd>silent nohlsearch<CR>")

-- <leader>cl en modo Normal: Abrir línea de comandos del sistema (command line)
vim.keymap.set("n", "<leader>cl", ":!")

-- <leader>hx en modo Normal: Convertir archivo a vista hexadecimal (hex view)
vim.keymap.set("n", "<leader>hx", "<cmd>silent %!xxd<CR><cmd>silent set ft=xxd<CR>")

-- <leader>fm en modo Normal: Formatear código usando LSP (format)
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

-- ======================
-- 4. Manejo de ventanas
-- ======================
-- División de ventanas
vim.keymap.set("n", "<leader>vp", "<cmd>vsplit<CR>")  -- Dividir verticalmente
vim.keymap.set("n", "<leader>hp", "<cmd>split<CR>")   -- Dividir horizontalmente

-- Redimensionamiento
vim.keymap.set("n", "<leader>+", "<cmd>vertical resize +5<CR>")  -- +5 columnas de ancho
vim.keymap.set("n", "<leader>-", "<cmd>vertical resize -5<CR>")  -- -5 columnas de ancho
vim.keymap.set("n", "<leader>_", "<cmd>resize -5<CR>")          -- -5 líneas de alto
vim.keymap.set("n", "<leader>=", "<cmd>resize +5<CR>")           -- +5 líneas de alto

-- Navegación entre ventanas
vim.keymap.set("n", "<C-h>", "<C-w>h")  -- Ir a ventana izquierda
vim.keymap.set("n", "<C-j>", "<C-w>j")  -- Ir a ventana inferior
vim.keymap.set("n", "<C-k>", "<C-w>k")  -- Ir a ventana superior
vim.keymap.set("n", "<C-l>", "<C-w>l")  -- Ir a ventana derecha

-- Movimiento de ventanas
vim.keymap.set("n", "<leader>wH", "<C-w>H")  -- Mover ventana a la izquierda
vim.keymap.set("n", "<leader>wJ", "<C-w>J")  -- Mover ventana abajo
vim.keymap.set("n", "<leader>wK", "<C-w>K")  -- Mover ventana arriba
vim.keymap.set("n", "<leader>wL", "<C-w>L")  -- Mover ventana a la derecha

-- Utilitarios
vim.keymap.set("n", "<leader>wm", "<C-w>|")  -- Maximizar ancho (100%)
vim.keymap.set("n", "<leader>wh", "<C-w>=")  -- Balancear tamaños-- ======================


-- 5. Navegación en listas
-- ======================
-- <C-k>/<C-j> en modo Normal: Navegar por la lista quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")  -- Siguiente error (centrado)
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")  -- Error anterior (centrado)

-- <leader>k/<leader>j en modo Normal: Navegar por la location list
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")  -- Siguiente ubicación (centrado)
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")  -- Ubicación anterior (centrado)
