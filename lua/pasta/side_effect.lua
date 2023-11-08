local SideEffect = {}

function SideEffect.prevent(callback)
  vim.diagnostic.disable(0)
  local ok, res = pcall(callback)
  vim.diagnostic.enable(0)
  if not ok then
    error(res)
  end
end

return SideEffect
