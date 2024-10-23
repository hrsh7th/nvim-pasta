local SideEffect = {}

function SideEffect.prevent(callback)
  local diagnostic_active = vim.diagnostic.is_enabled()
  if diagnostic_active then vim.diagnostic.enable(false) end
  local ok, res = pcall(callback)
  if diagnostic_active then vim.diagnostic.enable(true) end
  if not ok then
    error(res)
  end
end

return SideEffect
