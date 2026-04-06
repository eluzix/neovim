-- Show context of the current function
return {
  "nvim-treesitter/nvim-treesitter-context",
  enabled = false,
  event = "VeryLazy",
  opts = function()
    vim.keymap.set("n", "[c", function()
      require("treesitter-context").go_to_context(vim.v.count1)
    end, { silent = true })
    return { mode = "cursor", max_lines = 3 }
  end,
}
