
local ok, blink_cmp = pcall(require, "blink.cmp")
if not ok then
  vim.notify("blink.cmp no se pudo cargar", vim.log.levels.ERROR)
  return
end

blink_cmp.setup({
  keymap = {
    preset = 'none',

    ["<Tab>"]     = { "select_next", "fallback" },
    ["<S-Tab>"]   = { "select_prev", "fallback" },
    ["<Up>"]      = { "select_prev", "fallback" },
    ["<Down>"]    = { "select_next", "fallback" },

    ["<C-e>"]     = { "cancel" },
    ["<C-d>"]     = { "scroll_documentation_down", "fallback" },
    ["<C-u>"]     = { "scroll_documentation_up", "fallback" },

    ["<CR>"]      = { "accept", "fallback" },
    ["<C-y>"]     = { "accept" },
    ["<C-Space>"] = { "show", "show_documentation", "fallback" },
  },

  sources = {
    providers = {
      lsp = {},
      snippets = {},
      buffer = {},
      path = {},
    }
  },

  completion = {
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      }
    }
  }
})

