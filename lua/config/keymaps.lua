local keymap = vim.keymap

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set('n', '<leader>tt', '<Cmd>NvimTreeOpen<CR>', {})

-- Example: Map `<leader>/` to toggle comments
vim.api.nvim_set_keymap('n', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
-- Open error
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })
