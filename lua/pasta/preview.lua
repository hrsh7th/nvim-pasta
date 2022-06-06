local preview = {}

---@type number[]
preview.wins = {}

---Show preview windows
---@param index number
---@param history pasta.Entry[]
function preview.show(index, history)
  preview.hide()

  local s = 1
  local e = #history
  local has_prev = index > 1
  local has_next = index <= #history

  local state = {
    bottom = vim.o.lines - vim.o.cmdheight - 2
  }
  local buf, win
  if has_next then
    buf = preview.content('↓↓↓', 'plaintext')
    win = vim.api.nvim_open_win(
      buf,
      false,
      {
        relative = 'editor',
        anchor = 'SE',
        row = state.bottom,
        col = vim.o.columns - 2,
        width = preview.get_width(buf),
        height = 1,
        style = 'minimal'
      }
    )
    table.insert(preview.wins, win)

    state.bottom = state.bottom - vim.api.nvim_win_get_height(preview.wins[#preview.wins]) - 1
  end

  for i = e, s, -1 do
    local entry = history[i]
    buf = preview.content(entry.regcontents, vim.api.nvim_buf_get_option(0, 'filetype'))
    win = vim.api.nvim_open_win(
      buf,
      false,
      {
        relative = 'editor',
        anchor = 'SE',
        row = state.bottom,
        col = vim.o.columns - 2,
        width = preview.get_width(buf),
        height = vim.api.nvim_buf_line_count(buf),
        style = 'minimal'
      }
    )
    table.insert(preview.wins, win)

    if i == index then
      vim.api.nvim_win_set_option(win, 'winhighlight', 'Normal:PmenuSel')
    end

    state.bottom = state.bottom - vim.api.nvim_win_get_height(preview.wins[#preview.wins]) - 1
  end

  if has_prev then
    buf = preview.content('↑↑↑', 'plaintext')
    win = vim.api.nvim_open_win(
      buf,
      false,
      {
        relative = 'editor',
        anchor = 'SE',
        row = state.bottom,
        col = vim.o.columns - 2,
        width = preview.get_width(buf),
        height = 1,
        style = 'minimal'
      }
    )
    table.insert(preview.wins, win)

    state.bottom = state.bottom - vim.api.nvim_win_get_height(preview.wins[#preview.wins])
  end
end

---Hide all previews
function preview.hide()
  for _, win in ipairs(preview.wins) do
    vim.api.nvim_win_hide(win)
  end
  preview.wins = {}
end

function preview.content(text, filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, type(text) == 'table' and text or { text })
  vim.api.nvim_buf_set_option(buf, 'filetype', filetype)
  return buf
end

function preview.get_width(buf)
  local width = 0
  vim.api.nvim_buf_call(buf, function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
      width = math.max(vim.fn.strdisplaywidth(line), width)
    end
  end)
  return width
end

return preview
