return {
  "julienvincent/hunk.nvim",
  cmd = { "DiffEditor" },
  cond = function()
    return vim.fn.executable("hunk") == 1
  end,
  config = function()
    require("hunk").setup()
  end,
}
