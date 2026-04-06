local ensure_installed = { "c", "cpp", "zig", "lua", "vim", "vimdoc", "query", "elixir", "python", "rust", "typescript", "javascript", "html", "go", "yaml", "markdown", "markdown_inline" }
local installed = require("nvim-treesitter.config").get_installed()
local to_install = vim.iter(ensure_installed)
  :filter(function(parser)
    return not vim.tbl_contains(installed, parser)
  end)
  :totable()

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
