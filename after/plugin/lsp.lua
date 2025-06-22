--[[
  My LSP (Language Server Protocol) Configuration
  Features I use:
  - lsp-zero for simplified LSP setup
  - Key mappings for common LSP actions
  - Mason for automatic LSP installation
  - Auto-formatting on save
  - Advanced autocompletion (nvim-cmp)
  
  Languages I work with:
  - Python, Java, Rust
  - Web: HTML, JavaScript, CSS
  - SQL, Markdown
  - Lua (for Neovim config)
--]]

local lsp = require('lsp-zero')

-- My preferred LSP key mappings
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

-- Configure Mason to manage my LSP servers
local lspconfig = require('lspconfig')
require('mason').setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry",
  }
})

-- List of LSP servers I want automatically installed
require('mason-lspconfig').setup({
  ensure_installed = {
    'pyright',        -- Python
    'jdtls',          -- Java
    'rust_analyzer',  -- Rust
    'html',           -- HTML
    'cssls',          -- CSS
    'sqlls',          -- SQL
    'marksman',       -- executables       
  },
  handlers = {
    lsp.default_setup,
    -- Special configuration only for Lua
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      lspconfig.lua_ls.setup(vim.tbl_deep_extend("force", lua_opts, {
        cmd = { "/run/current-system/sw/bin/lua-language-server" }
      }))
    end,
    -- Minimal config for Rust
    rust_analyzer = function()
      lspconfig.rust_analyzer.setup({})
    end,
    -- Minimal config for Python
    pyright = function()
      lspconfig.pyright.setup({})
    end
  }
})

-- Auto-format files on save for these languages
lsp.format_on_save({
  format_opts = {
    async = false,
    timeout_ms = 10000,
  },
  servers = {
    ['tsserver'] = { "javascript", "typescript" },
    ['html'] = { 'html' },
    ['pyright'] = { 'python' },
    ['rust_analyzer'] = { 'rust' },
    ['jdtls'] = { 'java' },
    ['cssls'] = { 'css' },
    ['lua_ls'] = { 'lua' },
    ['marksman'] = { 'markdown' }
  },
})

-- My autocompletion setup (nvim-cmp)
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

-- Special setup for SQL (using vim-dadbod)
cmp.setup.filetype('sql', {
  sources = cmp.config.sources({
    { name = 'vim-dadbod-completion' },
    { name = 'buffer' },
  })
})

-- Additional configurations I find useful
vim.cmd([[autocmd FileType dbout setlocal nofoldenable]]) -- Disable folding for dbout
vim.diagnostic.config({ virtual_text = true }) -- Show diagnostic messages inline

-- Plugin integrations I use
require('nvim-autopairs').setup() -- Auto-pair brackets/quotes
require('nvim-ts-autotag').setup() -- Auto-close HTML tags
require('nvim-highlight-colors').setup() -- Color preview
