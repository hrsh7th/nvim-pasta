local SideEffect = {}

function SideEffect.prevent(callback)
  local is_enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(false, { bufnr = 0 })
  local ok, res = pcall(callback)
  vim.diagnostic.enable(is_enabled, { bufnr = 0 })
  if not ok then
    error(res)
  end
end

return SideEffect
