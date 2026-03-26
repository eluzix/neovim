local utils = require("utils")
if utils.executable("tracer") then
  vim.api.nvim_create_user_command("TheTracer", function()
    require("open_tui").open_float_term("tracer")
  end, {})
end

if utils.executable("healthee-cli") then
  vim.api.nvim_create_user_command("Hcli", function(opts)
    local cmd = "healthee-cli"
    local keep_open = opts.args == ""
    if opts.args ~= "" then
      cmd = cmd .. " " .. opts.args
      for arg in opts.args:gmatch("%S+") do
        if arg == "help" then
          keep_open = true
          break
        end
      end
    end
    require("open_tui").open_float_term(cmd, { keep_open = keep_open })
  end, { nargs = "*" })
end

if utils.executable("ddb-explorer") then
  vim.api.nvim_create_user_command("DDBExplorer", function()
    require("open_tui").open_float_term("ddb-explorer")
  end, {})
end
 
