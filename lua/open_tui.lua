local M = {}

function M.open_float_term(cmd, opts)
  opts = opts or {}
  local buf = vim.api.nvim_create_buf(false, true)
  local width = math.floor(vim.o.columns * 0.85)
  local height = math.floor(vim.o.lines * 0.85)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })
  if opts.keep_open then
    vim.fn.termopen(cmd)
  else
    vim.fn.termopen(cmd, {
      on_exit = function()
        vim.api.nvim_win_close(win, true)
      end,
    })
  end
  vim.cmd("startinsert")
end

return M
