local highlight = {}

highlight.ns = {
  range = vim.api.nvim_create_namespace('pasta.highlight.range'),
  cursor = vim.api.nvim_create_namespace('pasta.highlight.cursor'),
}

---Highlight pasted range.
---@param start number[]
---@param end_ number[]
function highlight.range(start, end_)
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.range, 0, -1)
  vim.api.nvim_buf_set_extmark(0, highlight.ns.range, start[1] - 1, start[2], {
    end_row = end_[1] - 1,
    end_col = end_[2],
    hl_group = 'PastaRange',
    hl_mode = 'replace',
  })
end

---Highlight pseudo cursor.
---@param pos number[]
function highlight.cursor(pos)
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.cursor, 0, -1)
  vim.api.nvim_buf_set_extmark(0, highlight.ns.cursor, pos[1] - 1, pos[2], {
    end_row = pos[1] - 1,
    end_col = pos[2] + 1,
    hl_group = 'PastaCursor',
    hl_mode = 'replace',
  })
end

---Clear highlights.
function highlight.clear()
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.range, 0, -1)
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.cursor, 0, -1)
end

return highlight
