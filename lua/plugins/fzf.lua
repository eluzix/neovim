return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "nvim-mini/mini.icons" },
  opts = {},
  config = function() 
    local fzf = require("fzf-lua")      
    fzf.setup({ }) 

    vim.keymap.set('n', '<leader>ff', fzf.files, {})
    vim.keymap.set('n', '<leader>fb', fzf.buffers, {})
    vim.keymap.set('n', '<leader>fh', fzf.oldfiles, {})
    vim.keymap.set('n', '<leader>fg', fzf.grep, {})
    vim.keymap.set('n', '<leader>fq', fzf.quickfix, {})
    vim.keymap.set('n', '<leader>fl', fzf.lsp_finder, {})
  end,
}
