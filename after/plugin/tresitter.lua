require 'nvim-treesitter.configs'.setup {
  -- I only install parsers for languages I actually use
  ensure_installed = {
    "python",      -- Python
    "java",        -- Java
    "rust",        -- Rust
    "html",        -- HTML
    "javascript",  -- JavaScript
    "typescript",  -- TypeScript (included since you use tsserver)
    "css",         -- CSS
    "sql",         -- SQL
    "markdown",    -- Markdown
    "lua",         -- Lua (for Neovim config)
    -- Base parsers needed for functionality
    "vim",
    "vimdoc",
    "query"
  },

  -- I prefer async installation to avoid freezing Neovim
  sync_install = false,

  -- Automatically install missing parsers when opening files
  auto_install = true,

  highlight = {
    enable = true,  -- Essential syntax highlighting

    -- I keep this disabled for better performance
    -- (I don't rely on legacy vim regex highlighting)
    additional_vim_regex_highlighting = false,
  },

  -- I might add more features here later but keeping it simple for now
}
