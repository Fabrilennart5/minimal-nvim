-- My plugin managment with Lazy.nvim
-- Installs:
-- Telescope (fuzzy finder)
-- Gruvbox (colorscheme)
-- Lsp/code tools (treesitter, lsp-zero)
-- Productivity (harpoon, undotree)
-- UI enhancements (lualune, nvim-tree)
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

-- Plugins
require('lazy').setup({
  {
    'nvim-telescope/telescope.nvim',
    module = "telescope",
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
    }
  },
  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      require('gruvbox').setup({
        transparent_mode = true,
        overrides = {
          Normal = {bg = "none"},
          NormalFloat = {bg = "none"},
          CursorLine =  {bg = "none"},
        }
      })
      vim.cmd.colorscheme("gruvbox")
    end
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {'ellisonleao/gruvbox.nvim'},
    opts = {
      theme = 'gruvbox',
      options = {
      component_separators = {left = "|", right = "|"},
      section_separators = {left = " ", right = " "},
      disabled_filetypes = {"packer", "Nvimtree"}
      }
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
  },

  -- LSP
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },

  {
    'theprimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim'
    }
  },
  {
    'mbbill/undotree'
  },
  { 'windwp/nvim-ts-autotag' },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
  },
  {
    'numToStr/Comment.nvim',
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    }
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  {
    'brenoprata10/nvim-highlight-colors',
  },

{
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = {
    'juansalvatore/git-dashboard-nvim',
    'nvim-lua/plenary.nvim'  -- Necesario para git-dashboard
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
}, {})
