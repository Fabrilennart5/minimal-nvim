local ok, blink_cmp = pcall(require, "blink.cmp")
if not ok then
  vim.notify("blink.cmp no se pudo cargar", vim.log.levels.ERROR)
  return
end

blink_cmp.setup({
  mappings = {
    ["<Tab>"] = "select_next",
    ["<S-Tab>"] = "select_prev",
    ["<CR>"] = "accept_and_enter",
    ["<C-e>"] = "cancel",
    ["<C-d>"] = "scroll_documentation_down",
    ["<C-u>"] = "scroll_documentation_up",
  },
})

