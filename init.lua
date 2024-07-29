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


-- local lspconfig = require('lspconfig')
-- lspconfig.pylsp.setup {
--   settings = {
--   }
-- }
--
-- lspconfig.rust_analyzer.setup {
--   -- Server-specific settings. See `:help lspconfig-setup`
--   settings = {
--     ['rust-analyzer'] = {
--     diagnostics = {
--         enable = false;
--       }
--       },
--   },
-- }
--
-- require'lspconfig'.pylsp.setup{}
-- require'lspconfig'.tsserver.setup{}
--
