local VisualMode = {}

---Return visual mode.
---@return string?
function VisualMode.visual()
  return ({ ['v'] = 'v', ['V'] = 'V', [''] = '' })[vim.api.nvim_get_mode().mode]
end

---Return visual range.
---@return fun()
function VisualMode.savepoint()
  local range = {}
  local visual = VisualMode.visual()
  if visual then
    vim.cmd.normal({ 'o', bang = true })
    range.finish = vim.api.nvim_win_get_cursor(0)
    vim.cmd.normal({ 'o', bang = true })
    range.start = vim.api.nvim_win_get_cursor(0)
  end
  return function()
    if not visual then
      return
    end
    vim.cmd(([[
      normal! %sG%s|%s%sG%s|
    ]]):format(
      range.finish[1],
      range.finish[2] + 1,
      visual,
      range.start[1],
      range.start[2] + 1
    ))
  end
end

return VisualMode
