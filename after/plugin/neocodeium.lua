local neocodeium = require("neocodeium")

neocodeium.setup({
  enabled = true, -- Enabled by default
  show_label = true, -- Show suggestion counter
  debounce = false, -- Disable debounce for faster responses
  filetypes = {
    help = false, -- Disable in help files
    gitcommit = false, -- Disable in commit messages
  },
})

-- Essential keymaps
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("i", "<A-f>", neocodeium.accept, vim.tbl_extend("force", opts, { desc = "Accept Codeium suggestion" }))
map("i", "<A-w>", neocodeium.accept_word, vim.tbl_extend("force", opts, { desc = "Accept Codeium word" }))
map("i", "<A-l>", neocodeium.accept_line, vim.tbl_extend("force", opts, { desc = "Accept Codeium line" }))
map("i", "<A-n>", function() neocodeium.cycle_or_complete(1) end, vim.tbl_extend("force", opts, { desc = "Next Codeium suggestion" }))
map("i", "<A-p>", function() neocodeium.cycle_or_complete(-1) end, vim.tbl_extend("force", opts, { desc = "Previous Codeium suggestion" }))
map("i", "<A-c>", neocodeium.clear, vim.tbl_extend("force", opts, { desc = "Clear Codeium suggestion" }))

