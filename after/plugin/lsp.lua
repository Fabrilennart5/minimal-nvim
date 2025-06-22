--[[
  My LSP (Language Server Protocol) Configuration
  Features:
  - lsp-zero for simplified LSP setup
  - Key mappings for common LSP actions
  - Mason for automatic LSP installation
  - Auto-formatting on save
  - Advanced autocompletion (nvim-cmp)
  - Language-specific configurations

  Configured for:
  - Lua, Go, C/C++, HTML, TypeScript, Assembly
  - SQL via vim-dadbod
  - Additional tooling (autopairs, autotag, color highlighting)
--]]

local lsp = require('lsp-zero')

-- LSP key mappings for common actions
lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  -- Navigation
  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts) -- Go to definition
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts) -- Find references
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts) -- Show documentation
  
  -- Diagnostics
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts) -- Workspace symbols
  vim.keymap.set("n", "<leader>ge", function() vim.diagnostic.open_float() end, opts) -- Show diagnostic
  vim.keymap.set("n", "<leader>ne", function() vim.diagnostic.goto_next() end, opts) -- Next diagnostic
  vim.keymap.set("n", "<leader>pe", function() vim.diagnostic.goto_prev() end, opts) -- Previous diagnostic
  
  -- Code actions
  vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts) -- Code actions
  vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts) -- Rename symbol
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts) -- Signature help
end)

-- Mason configuration for LSP installation
local lspconfig = require('lspconfig')
require('mason').setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  }
})

-- Language servers to auto-install
require('mason-lspconfig').setup({
  ensure_installed = {
    'html', 'clangd', 'emmet_language_server', 'gopls', 
    'lua_ls', 'ts_ls', 'asm_lsp'
  },
  handlers = {
    lsp.default_setup,
    -- Language-specific configurations
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      lspconfig.lua_ls.setup(lua_opts)
    end,
    gopls = function()
      lspconfig.gopls.setup({
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            }
          }
        },
      })
    end,
    asm_lsp = function()
      lspconfig.asm_lsp.setup({})
    end,
  }
})

-- Auto-formatting on save with timeout
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['ts_ls'] = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescript.tsx", "typescriptreact", "astro", "svelte", "css" },
    ['html'] = { 'html' },
    ['clangd'] = { 'c', 'cpp', 'h', 'hpp' },
    ['gopls'] = { 'go' },
    ['lua_ls'] = { 'lua' },
    ['asm_lsp'] = { 'asm', 's', 'S' },
  },
})

-- Autocompletion setup with nvim-cmp
local cmp = require('cmp')
local cmp_format = lsp.cmp_format()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = cmp.mapping.preset.insert({
  ['<C-k>'] = cmp.mapping.select_prev_item(cmp_select), -- Navigate up
  ['<C-j>'] = cmp.mapping.select_next_item(cmp_select), -- Navigate down
  ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm selection
  ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion
})

-- Disable tab mapping to avoid conflicts
cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

cmp.setup({
  formatting = cmp_format,
  mapping = cmp_mappings
})

-- Special setup for SQL via vim-dadbod
cmp.setup.filetype('sql', {
  sources = cmp.config.sources({
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  })
})

-- Additional configurations
vim.cmd([[autocmd FileType dbout setlocal nofoldenable]]) -- Disable folding for dbout
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages inline
vim.g.c_syntax_for_h = 1 -- Treat .h files as C files

-- Plugin integrations
require('nvim-autopairs').setup() -- Auto-pair brackets/quotes
require('nvim-ts-autotag').setup() -- Auto-close HTML tags
require('nvim-highlight-colors').setup() -- Color preview
