-- =============================================
-- Configuración básica de Lazy.nvim (gestor de plugins)
-- =============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Instalación de Lazy.nvim si no está presente
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- =============================================
-- Configuración de plugins
-- =============================================
require('lazy').setup({
  -- ======================
  -- 🔍 Búsqueda y navegación
  -- ======================
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'stevearc/oil.nvim', dependencies = { 'echasnovski/mini.icons' } },  -- Explorador de archivos

  -- ======================
  -- 🛠 LSP y herramientas de código
  -- ======================
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },  -- Configuración básica de LSP
  { 'neovim/nvim-lspconfig' },                       -- Configuraciones para servidores LSP
  { 'williamboman/mason.nvim' },                     -- Gestor de paquetes LSP
  { 'williamboman/mason-lspconfig.nvim' },           -- Puente entre Mason y lspconfig
  { 'hrsh7th/nvim-cmp' },                            -- Motor de autocompletado
  { 'hrsh7th/cmp-nvim-lsp' },                        -- Fuente de autocompletado para LSP
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },  -- Mejor sintaxis y resaltado
  { 'nvim-treesitter/nvim-treesitter-context' },     -- Muestra contexto en código largo
  { 'rhysd/git-messenger.vim', dependencies = { 'nvim-lua/plenary.nvim' } },  -- Información de Git

  -- ======================
  -- ⚡ Productividad
  -- ======================
  { 'windwp/nvim-ts-autotag' },                      -- Autocompletado de tags HTML/XML
  { 'windwp/nvim-autopairs', event = 'InsertEnter' },-- Autocompletado de pares () {} []
  { 'numToStr/Comment.nvim' },                       -- Comentar código fácilmente

  -- ======================
  -- 💻 Mejoras de interfaz
  -- ======================
  { 'ellisonleao/gruvbox.nvim' },                    -- Tema de colores
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },  -- Barra de estado
  { 'brenoprata10/nvim-highlight-colors' },          -- Resaltado de colores HEX/RGB
  { 'vyfor/cord.nvim', build = ':Cord update', event = 'VeryLazy' },  -- Discord Rich Presence
  { 'nvimdev/dashboard-nvim', event = 'VimEnter', dependencies = { 'juansalvatore/git-dashboard-nvim', 'nvim-lua/plenary.nvim' } },  -- Pantalla de inicio
  { 'nvim-tree/nvim-web-devicons' },                 -- Iconos para el sistema

  -- ======================
  -- 🐞 Depuración (DAP)
  -- ======================
  {
    "mfussenegger/nvim-dap",                         -- Depuración con Debug Adapter Protocol
    dependencies = {
      "nvim-neotest/nvim-nio",                       -- Operaciones asíncronas
      "rcarriga/nvim-dap-ui",                        -- Interfaz visual para DAP
      "mfussenegger/nvim-dap-python",                -- Debugger para Python
      "theHamsta/nvim-dap-virtual-text"              -- Muestra valores de variables
    },
  },

  -- ======================
  -- 📟 Terminal integrado
  -- ======================
  { 'akinsho/toggleterm.nvim', version = '*' },      -- Terminal integrado
})
