local SideEffect = {}

function SideEffect.prevent(callback)
  vim.diagnostic.enable(false)
  local ok, res = pcall(callback)
  vim.diagnostic.enable(true)
  if not ok then
    error(res)
  end
end

return SideEffect
