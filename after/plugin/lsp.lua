-- after/plugin/lsp.lua

local lspconfig = require('lspconfig')             -- Este módulo me permite configurar los servidores LSP
local mason = require('mason')                     -- Mason es un gestor que me ayuda a instalar servidores LSP y otras herramientas automáticamente
local mason_lspconfig = require('mason-lspconfig') -- Este conecta Mason con lspconfig para que la instalación y configuración sea más sencilla
local blink = require('blink.cmp')                 -- blink.cmp es el plugin que uso para el autocompletado avanzado

-- 1. Configurar Mason para que gestione la instalación de servidores LSP
-- Esto me asegura que Mason esté listo para instalar y actualizar servidores cuando sea necesario
mason.setup()

-- 2. Le digo a Mason qué servidores LSP quiero que instale automáticamente para los lenguajes que uso
-- Aquí agrego los servidores para Rust, Python (usando Ruff), Lua y Java
mason_lspconfig.setup({
  ensure_installed = {
    'rust_analyzer', -- Servidor para Rust
    'ruff',          -- Servidor para Python usando Ruff
    'lua_ls',        -- Servidor para Lua (muy útil para configurar Neovim)
    'jdtls',         -- Servidor para Java
  },
})

-- 3. Creo las capacidades que usarán todos mis servidores LSP
-- Las capacidades definen qué funcionalidades soporta el cliente LSP, aquí las extiendo con las que provee blink.cmp para autocompletado
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, blink.get_lsp_capabilities())

-- 4. Defino una función para configurar los servidores de forma sencilla y consistente
-- Esta función recibe el nombre del servidor y opciones específicas, y siempre le pasa las capacidades extendidas
local function setup_server(server_name, opts)
  opts = opts or {}
  opts.capabilities = capabilities
  lspconfig[server_name].setup(opts)
end

-- 5. Configuro el servidor Rust Analyzer para Rust
-- Aquí podría agregar opciones específicas si quiero, pero por ahora uso la configuración por defecto con capacidades extendidas
setup_server('rust_analyzer')

-- 6. Configuro el servidor Ruff para Python
-- Igual que con Rust, uso la configuración básica con capacidades extendidas
setup_server('ruff')

-- 7. Configuro el servidor Lua Language Server con opciones especiales
-- Esto es importante para que reconozca el entorno de Neovim (por ejemplo la variable global 'vim') y no marque errores innecesarios
setup_server('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },                             -- Le digo que 'vim' es una variable global válida
      workspace = { library = vim.api.nvim_get_runtime_file("", true) }, -- Incluyo las librerías runtime de Neovim para autocompletado
      telemetry = { enable = false },                                    -- Desactivo la telemetría para privacidad
    },
  },
})

-- 8. Configuro el servidor Java (jdtls)
-- De nuevo, configuración básica con capacidades extendidas, puedes agregar opciones si quieres
setup_server('jdtls')

-- 9. Configuro un autocmd para autoformatear el código al guardar
-- Esto aplica a los archivos con extensiones de los lenguajes que uso (Rust, Python, Lua, Java)
-- Solo se formatea si el servidor LSP conectado soporta formateo
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { "*.rs", "*.py", "*.lua", "*.java" },
  callback = function()
    local clients = vim.lsp.get_active_clients({ bufnr = vim.api.nvim_get_current_buf() })
    for _, client in pairs(clients) do
      if client.supports_method("textDocument/formatting") then
        vim.lsp.buf.format({ async = false })
        break
      end
    end
  end,
})

-- 10. Configuro las opciones de diagnóstico visual en Neovim
-- Esto controla cómo se muestran los errores y advertencias en el editor
vim.diagnostic.config({
  virtual_text = true,      -- Mostrar mensajes inline
  signs = true,             -- Mostrar signos en la columna lateral
  update_in_insert = false, -- No actualizar diagnósticos mientras escribo
  underline = true,         -- Subrayar el texto con problemas
  severity_sort = true,     -- Ordenar diagnósticos por severidad
})

-- 11. Finalmente, configuro blink.cmp para el autocompletado
-- Aquí defino los atajos de teclado, apariencia y otras opciones para que la experiencia sea fluida y agradable
require('blink.cmp').setup({
  keymap = { preset = 'default' },
  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = 'mono',
  },
  signature = { enabled = true },
})

-- ===== Cómo agregar más lenguajes o servidores =====
-- 1. Primero asegúrate que Mason tenga el servidor disponible (https://github.com/williamboman/mason.nvim#available-packages)
-- 2. Agrega el nombre del servidor en la lista 'ensure_installed' para que Mason lo instale automáticamente
-- 3. En el bloque donde configuro servidores, agrega una llamada a setup_server con el nombre del servidor
-- 4. Si el servidor requiere configuración especial, pásale las opciones en el segundo parámetro de setup_server
-- 5. Si quieres que se autoformatee, añade la extensión del archivo en el patrón del autocmd de formateo
