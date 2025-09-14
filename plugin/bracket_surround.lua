-- File: plugin/bracket_surround.lua
-- Fix: don't shadow Lua's pairs() by naming our table "mappings".

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(ev)
    local mappings = {
      ["{"] = "{}<Left>",
      ["["] = "[]<Left>",
      ["("] = "()<Left>",
    }
    for open, expand in pairs(mappings) do
      vim.keymap.set("i", open, function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local col0 = pos[2]
        local line = vim.api.nvim_get_current_line()
        local next_char = line:sub(col0 + 2, col0 + 2)
        if next_char == expand:sub(2, 2) then return open end
        return expand
      end, { buffer = ev.buf, expr = true, noremap = true, silent = true })
    end
  end,
})
