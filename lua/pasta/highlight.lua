local highlight = {}

highlight.ns = {
  cursor = vim.api.nvim_create_namespace('pasta.highlight.cursor'),
  entry = vim.api.nvim_create_namespace('pasta.highlight.contents'),
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

---@param cursor { [1]: integer, [2]: integer }
---@param entry pasta.Entry
function highlight.entry(cursor, entry)
  local highlights = {}
  if entry.regtype == 'v' then
    if #entry.regcontents == 1 then
      table.insert(highlights, {
        row = cursor[1] - 1,
        col = cursor[2] - #entry.regcontents[1] + 1,
        end_col = cursor[2],
      })
    else
      for i, line in ipairs(entry.regcontents) do
        if i == 1 then
          table.insert(highlights, {
            row = cursor[1] + i - 2,
            col = cursor[2] + 1,
            end_col = cursor[2] + #line,
          })
        else
          table.insert(highlights, {
            row = cursor[1] + i - 2,
            col = 0,
            end_col = #line,
          })
        end
      end
    end
  elseif entry.regtype == 'V' then
    for i, line in ipairs(entry.regcontents) do
      table.insert(highlights, {
        row = cursor[1] + i - 2,
        col = 0,
        end_col = #line,
      })
    end
  elseif entry.regtype:find(vim.api.nvim_replace_termcodes('<C-v>', true, true, true), 1, true) then
    for i, line in ipairs(entry.regcontents) do
      table.insert(highlights, {
        row = cursor[1] + i - 2,
        col = cursor[2],
        end_col = cursor[2] + #line,
      })
    end
  end

  for _, hi in ipairs(highlights) do
    vim.api.nvim_buf_set_extmark(0, highlight.ns.entry, hi.row, hi.col, {
      end_row = hi.row,
      end_col = hi.end_col,
      hl_group = 'PastaEntry'
    })
  end
end

---Clear highlights.
function highlight.clear()
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.cursor, 0, -1)
  vim.api.nvim_buf_clear_namespace(0, highlight.ns.entry, 0, -1)
end

return highlight
