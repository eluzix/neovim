local configs = require("nvim-treesitter.configs")

configs.setup({
  ensure_installed = { "c", "cpp", "zig", "lua", "vim", "vimdoc", "query", "elixir", "python", "rust", "typescript", "javascript", "html", "go" },
  sync_install = false,
  highlight = { enable = true },
  indent = { enable = true },
})
