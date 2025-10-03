return {
  "fatih/vim-go",

  config = function()
    vim.g.go_def_mode = 'gopls'
    vim.g.go_info_mode = 'gopls'

      vim.g.go_debug_windows = { ["vars"] = "rightbelow 8new",
      ["stack"] = "rightbelow 3new",
      -- ["goroutines"] = "rightbelow 10new",
      ["output"] = "right 5new",
      -- ["locals"] = "rightbelow 10new",
      -- ["registers"] = "rightbelow 10new"
    }

    vim.g.go_debug_mapping = {
      ["go-debug-continue"] = "{'key': '<F9>'}",
      ["go-debug-step"] = "{'key': '<F7>'}",
      ["go-debug-next"] = "{'key': '<F8>'}",
      ["go-debug-print"] = "{'key': '<F5>'}",
    }
  end
}
