-- Set keymap for GitMessenger popup
vim.keymap.set("n", "<leader>gm", ":GitMessenger<CR>", { noremap = true, silent = true, desc = "Show git commit message" })

-- Automatically close popup when cursor moves
vim.g.git_messenger_close_on_cursor_moved = true

