return {
  "nicolasgb/jj.nvim",
  version = "*", -- Use latest stable release
  config = function()
    local jj = require("jj")
    jj.setup({})

    local cmd = require("jj.cmd")
    vim.keymap.set("n", "<leader>jd", cmd.diff, { desc = "JJ diff" }) 
    vim.keymap.set("n", "<leader>jds", cmd.describe, { desc = "JJ describe" }) 
    vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
    vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
    vim.keymap.set("n", "<leader>jst", cmd.status, { desc = "JJ status" })
    vim.keymap.set("n", "<leader>ju", cmd.undo, { desc = "JJ undo" })
    vim.keymap.set("n", "<leader>jr", cmd.rebase, { desc = "JJ rebase" })
    vim.keymap.set("n", "<leader>jp", cmd.push, { desc = "JJ push" })

    local diff = require("jj.diff")
    vim.keymap.set("n", "<leader>df", function() diff.open_vdiff() end, { desc = "JJ diff current buffer" })
    vim.keymap.set("n", "<leader>dF", function() diff.open_hsplit() end, { desc = "JJ hdiff current buffer" })

  end,
}
