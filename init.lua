require("config.lazy")
require("config.cmp")
require("config.opts")
require("config.keymaps")

vim.cmd.colorscheme("darcula-dark")

-- Telescop
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fs', builtin.treesitter, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- Example: Map `<leader>/` to toggle comments
vim.api.nvim_set_keymap('n', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })

-- Create an augroup for LSP formatting on save
vim.api.nvim_create_augroup("lsp_format_on_save", {})

-- Set up an autocmd to format on save for all file types
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "lsp_format_on_save",
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
})

