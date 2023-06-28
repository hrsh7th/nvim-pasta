local highlight = {}

highlight.ns = {
  cursor = vim.api.nvim_create_namespace('pasta.highlight.cursor'),
}

---Highlight pseudo cursor.
---@param pos number[]
function highlight.cursor(pos)
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.cursor, 0, -1)
  local ok = pcall(function()
    vim.api.nvim_buf_set_extmark(0, highlight.ns.cursor, pos[1] - 1, pos[2], {
      end_row = pos[1] - 1,
      end_col = pos[2] + 1,
      hl_group = 'PastaCursor',
      hl_mode = 'replace',
    })
  end)
  if not ok then
    vim.api.nvim_buf_set_extmark(0, highlight.ns.cursor, pos[1] - 1, pos[2], {
      virt_text = { { ' ', 'PastaCursor' } },
      virt_text_pos = 'overlay',
      strict = false,
    })
  end
end

---Clear highlights.
function highlight.clear()
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.cursor, 0, -1)
end

return highlight
