local Cursor = {}

function Cursor.hide(callback)
  if vim.fn.reg_executing() ~= '' then
    return callback()
  end
  local cursor_blend = vim.api.nvim_get_hl(0, { name = 'Cursor' }).blend
  vim.cmd('hi Cursor blend=100')
  vim.cmd('set guicursor+=a:Cursor')
  local ok, res = pcall(callback)
  vim.cmd(('hi Cursor blend=%s'):format(cursor_blend))
  vim.cmd('set guicursor+=a:Cursor')
  if not ok then
    error(res)
  end
end

function Cursor.safe(callback)
  local pos = vim.fn.getpos('.')
  local ok, res = pcall(callback)
  vim.fn.setpos('.', pos)
  if not ok then
    error(res)
  end
end

return Cursor
