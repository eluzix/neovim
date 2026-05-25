local macros = {
  -- preettify json
  J = ':%!jq .\r',
  -- fix ' to " in json and prettify
  K = ':%!tr "\'" \'"\' | jq .\r',
}

for reg, content in pairs(macros) do
  vim.fn.setreg(reg, content)
end
