
-- My plugin management with Lazy.nvim
-- Includes:
-- 🔍 Telescope (fuzzy finder)
-- 🎨 Gruvbox (colorscheme)
-- 🛠 LSP & code tools (treesitter, lsp-zero, mason, etc.)
-- ⚡ Productivity (harpoon, undotree, oil.nvim)
-- 💻 UI enhancements (lualine, nvim-tree, dashboard, highlight-colors)
-- 📟 Terminal integration (toggleterm)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

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

require('lazy').setup({
  -- 🔍 Telescope (fuzzy finder)
  { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },


  -- 🛠 LSP & code tools
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  { 'rhysd/git-messenger.vim', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- ⚡ Productivity
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs', event = 'InsertEnter' },
  { 'numToStr/Comment.nvim' },
  { 'stevearc/oil.nvim', dependencies = { 'echasnovski/mini.icons' } },

  -- 💻 UI enhancements
  { 'ellisonleao/gruvbox.nvim' },
  {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }},
  { 'brenoprata10/nvim-highlight-colors' },
  { 'vyfor/cord.nvim', build = ':Cord update', event = 'VeryLazy' },
  { 'nvimdev/dashboard-nvim', event = 'VimEnter', dependencies = { 'juansalvatore/git-dashboard-nvim', 'nvim-lua/plenary.nvim' } },
  { 'nvim-tree/nvim-web-devicons' },

  -- 🐞 Debug Adapter Protocol (DAP) for debugging support
{
  "mfussenegger/nvim-dap",
  dependencies = {
    "nvim-neotest/nvim-nio",        -- Necesario para operaciones asíncronas
    "rcarriga/nvim-dap-ui",         -- Interfaz visual para DAP
    "mfussenegger/nvim-dap-python", -- Debugger específico para Python
    "theHamsta/nvim-dap-virtual-text" -- Muestra valores de variables durante debugging
  },
},

  
  -- 📟 Terminal integration
  { 'akinsho/toggleterm.nvim', version = '*' },
})

