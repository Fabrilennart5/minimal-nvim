require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',                  -- Use explicitly the gruvbox theme
    component_separators = { left = '', right = '' },  -- Separators entre componentes
    section_separators = { left = '', right = '' },    -- Separators entre secciones
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,         -- Siempre mostrar la línea de tabs
    globalstatus = true,                 -- Statusline global para todas las ventanas (neovim 0.7+)
    refresh = {
      statusline = 1000,                -- Refrescar statusline cada 1000ms
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16,                -- 60fps approx
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = { 'mode' },                             -- Modo actual (NORMAL, INSERT, etc)
    lualine_b = { 'branch', 'diff', 'diagnostics' },   -- Branch git, diff y diagnósticos (error/warning)
    lualine_c = { 'filename' },                         -- Nombre archivo activo
    lualine_x = { 'encoding', 'fileformat', 'filetype' }, -- Codificación, formato y tipo de archivo
    lualine_y = { 'progress' },                         -- Progreso en el archivo (línea %)
    lualine_z = { 'location' },                         -- Ubicación exacta (línea:columna)
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },                         -- Solo mostrar filename en ventanas inactivas
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},       -- Puedes agregar configuración para tabline aquí si quieres
  winbar = {},        -- Winbar vacía, puedes personalizar si quieres
  inactive_winbar = {},
  extensions = {},    -- Aquí puedes añadir extensiones como 'fzf', 'nvim-tree', etc
}

