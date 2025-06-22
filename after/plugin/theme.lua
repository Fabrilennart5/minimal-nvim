-- after/plugin/theme.lua
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })

-- To ensure the theme is loaded
if vim.g.colors_name ~= 'gruvbox' then
  vim.cmd.colorscheme('gruvbox')
end
