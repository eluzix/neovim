local keymap = vim.keymap

keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

keymap.set('n', '<leader>tt', '<Cmd>NvimTreeOpen<CR>', {})

-- Example: Map `<leader>/` to toggle comments
vim.api.nvim_set_keymap('n', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>/', ':CommentToggle<CR>', { noremap = true, silent = true })
-- Open error
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })


vim.api.nvim_set_keymap("n", "<Leader>b", ":GoDebugBreakpoint<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ggr", ":GoDebugStart<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>ggc", ":GoDebugContinue<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<F8>", ":GoDebugNext<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<F7>", ":GoDebugStep<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<Leader>ca", "vim.lsp.buf.code_action", {})

-- close current buffer
vim.api.nvim_set_keymap("n", "<Leader>ww", ":bd<CR>", {})


 --- DAP config start --- 

local function with_dap(callback)
  local ok, dap = pcall(require, "dap")
  if not ok then
    vim.notify("nvim-dap is not available", vim.log.levels.WARN, { title = "keymaps" })
    return
  end
  callback(dap)
end

local function with_dapui(callback)
  local ok, dapui = pcall(require, "dapui")
  if not ok then
    vim.notify("nvim-dap-ui is not available", vim.log.levels.WARN, { title = "keymaps" })
    return
  end
  callback(dapui)
end

local function dap_action(action, desc)
  keymap.set("n", action.lhs, function()
    with_dap(function(dap)
      action.run(dap)
    end)
  end, { silent = true, desc = desc })
end

dap_action({ lhs = "<leader>dd", run = function(dap) dap.continue() end }, "Debug: Start/Continue")
dap_action({ lhs = "<leader>db", run = function(dap) dap.toggle_breakpoint() end }, "Debug: Toggle Breakpoint")
dap_action({ lhs = "<leader>di", run = function(dap) dap.step_into() end }, "Debug: Step Into")
dap_action({ lhs = "<leader>dn", run = function(dap) dap.step_over() end }, "Debug: Step Over")
dap_action({ lhs = "<leader>do", run = function(dap) dap.step_out() end }, "Debug: Step Out")
dap_action({ lhs = "<leader>dq", run = function(dap) dap.terminate() end }, "Debug: Stop")
dap_action({ lhs = "<leader>dr", run = function(dap) dap.repl.toggle() end }, "Debug: Toggle REPL")

keymap.set("n", "<leader>du", function()
  with_dapui(function(dapui)
    dapui.toggle()
  end)
end, { silent = true, desc = "Debug: Toggle UI" })

-- IntelliJ IDEA-style debug mappings.
dap_action({ lhs = "<F9>", run = function(dap) dap.continue() end }, "Debug: Resume Program")
dap_action({ lhs = "<F8>", run = function(dap) dap.step_over() end }, "Debug: Step Over")
dap_action({ lhs = "<F7>", run = function(dap) dap.step_into() end }, "Debug: Step Into")
dap_action({ lhs = "<S-F8>", run = function(dap) dap.step_out() end }, "Debug: Step Out")
-- f56 = opt+f8
dap_action({ lhs = "<F56>", run = function(dap) dap.toggle_breakpoint() end }, "Debug: Toggle Breakpoint")
-- f53 = opt+f5
dap_action({ lhs = "<F53>", run = function(dap) dap.terminate() end }, "Debug: Stop")

keymap.set("n", "<S-F11>", function()
  with_dapui(function(dapui)
    dapui.toggle()
  end)
end, { silent = true, desc = "Debug: Toggle UI" })

dap_action({ lhs = "<A-F8>", run = function(dap) dap.repl.toggle() end }, "Debug: Evaluate/REPL")

-- Terminal fallback codes for modified function keys.
-- dap_action({ lhs = "<F20>", run = function(dap) dap.step_out() end }, "Debug: Step Out (Shift+F8 fallback)")
-- dap_action({ lhs = "<F32>", run = function(dap) dap.toggle_breakpoint() end }, "Debug: Toggle Breakpoint (Ctrl+F8 fallback)")
-- dap_action({ lhs = "<F26>", run = function(dap) dap.terminate() end }, "Debug: Stop (Ctrl+F2 fallback)")

 --- DAP config end --- 
