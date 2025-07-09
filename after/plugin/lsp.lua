local lspconfig = require('lspconfig')
local mason = require('mason')
local mason_lspconfig = require('mason-lspconfig')
local blink = require('blink.cmp')

-- Configuración mejorada de Mason
mason.setup({
  ui = {
    border = 'rounded',
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lspconfig.setup({
  ensure_installed = { 'rust_analyzer', 'ruff', 'jdtls' },
  automatic_installation = true, -- Instalación automática al abrir archivos
})

-- Capacidades mejoradas
local capabilities = blink.get_lsp_capabilities()
-- Añadir capacidades adicionales si es necesario
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Función de configuración mejorada
local function setup_server(server_name, opts)
  opts = opts or {}
  opts.capabilities = capabilities
  opts.flags = {
    debounce_text_changes = 150, -- Optimización de rendimiento
  }
  lspconfig[server_name].setup(opts)
end

-- Configuraciones específicas de servidores (mantén tus configuraciones actuales)
setup_server('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = {
        command = "clippy",
      },
    }
  }
})

setup_server('ruff')

setup_server('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- Mejor rendimiento
      },
      telemetry = { enable = false },
    },
  },
})

setup_server('jdtls')

-- Autocomandos mejorados
local lsp_group = vim.api.nvim_create_augroup('LSPConfig', { clear = true })

-- Autoformateo mejorado
vim.api.nvim_create_autocmd('BufWritePre', {
  group = lsp_group,
  pattern = { "*.rs", "*.py", "*.lua", "*.java" },
  callback = function()
    if vim.g.autoformat_enabled then -- Puedes controlarlo con una variable
      vim.lsp.buf.format({
        async = false,
        filter = function(client)
          return client.name ~= "ruff" -- Ejemplo: excluir ruff si es necesario
        end
      })
    end
  end,
})

-- Diagnósticos mejorados
vim.diagnostic.config({
  virtual_text = {
    prefix = '●', -- Icono más claro
    spacing = 2,
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-- Mapeos útiles
vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, { desc = 'Mostrar diagnóstico' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnóstico anterior' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnóstico siguiente' })
