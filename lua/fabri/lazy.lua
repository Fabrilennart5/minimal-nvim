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
  -- Telescope (fuzzy finder)
  {
    'nvim-telescope/telescope.nvim',
    module = "telescope",
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'ellisonleao/gruvbox.nvim' },
    opts = {
      theme = 'gruvbox',
      options = {
        component_separators = { left = "|", right = "|" },
        section_separators = { left = " ", right = " " },
        disabled_filetypes = { "packer", "Nvimtree" },
      }
    }
  },

  -- Syntax highlighting and code context
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-context' },
  {"rhysd/git-messenger.vim", dependencies = { "nvim-lua/plenary.nvim" },},


  -- LSP and completion tools
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  {"monkoose/neocodeium", event = "VeryLazy"},


  -- Productivity tools
  { 'mbbill/undotree' },
  { 'windwp/nvim-ts-autotag' },
  { 'windwp/nvim-autopairs', event = "InsertEnter" },
  { 'numToStr/Comment.nvim' },
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "echasnovski/mini.icons" },
    lazy = false,
  },
  
  -- Terminal integration
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  },

  -- UI enhancements
  {'nvim-tree/nvim-web-devicons' },
  {"vyfor/cord.nvim", build = ":Cord update", event = "VeryLazy" },
  { 'brenoprata10/nvim-highlight-colors' },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    dependencies = {
      'juansalvatore/git-dashboard-nvim',
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local git_header = require('git-dashboard-nvim').setup()
      require('dashboard').setup({
        theme = 'doom',
        config = {
          header = git_header,
          center = {
            { icon = ' ', desc = 'New file', action = 'ene | startinsert' },
            { icon = ' ', desc = 'Find file', action = 'Telescope find_files' },
          }
        }
      })
    end
  },
})

