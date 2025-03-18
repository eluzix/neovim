local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "python", "rust", "typescript", "javascript", "html" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
