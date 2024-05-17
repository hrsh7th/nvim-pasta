local keycode = vim.keycode or function(key)
  return vim.api.nvim_replace_termcodes(key, true, true, true)
end

local Highlight = {}

Highlight.ns = {
  cursor = vim.api.nvim_create_namespace('pasta.highlight.cursor'),
  entry = vim.api.nvim_create_namespace('pasta.highlight.contents'),
}

---Add highlight to pseudo cursor and entry.
---@param cursor { [1]: integer, [2]: integer }
---@param entry pasta.Entry
---@param visual? string
function Highlight.set(cursor, entry, visual)
  Highlight.clear()
  Highlight.set_entry(cursor, entry, visual)
  Highlight.set_cursor(cursor)
end

---Highlight pseudo cursor.
---@param pos { [1]: integer, [2]: integer }i
function Highlight.set_cursor(pos)
  if vim.fn.reg_executing() ~= '' then
    return
  end

  vim.api.nvim_buf_clear_namespace(0, Highlight.ns.cursor, 0, -1)
  local ok = pcall(function()
    vim.api.nvim_buf_set_extmark(0, Highlight.ns.cursor, pos[1] - 1, pos[2], {
      end_row = pos[1] - 1,
      end_col = pos[2] + 1,
      hl_group = 'PastaCursor',
      hl_mode = 'replace',

    })
  end)
  if not ok then
    -- for virtualedit=onemore and cursor placed at the end of line + 1.
    vim.api.nvim_buf_set_extmark(0, Highlight.ns.cursor, pos[1] - 1, pos[2], {
      virt_text = { { ' ', 'PastaCursor' } },
      virt_text_pos = 'overlay',
      strict = false,
    })
  end
end

---@param cursor { [1]: integer, [2]: integer }
---@param entry pasta.Entry
---@param visual? string
function Highlight.set_entry(cursor, entry, visual)
  if vim.fn.reg_executing() ~= '' then
    return
  end

  local highlights = {}
  if entry.regtype == 'v' then
    if visual ~= 'V' then
      if #entry.regcontents == 1 then
        table.insert(highlights, {
          row = cursor[1] - 1,
          col = (1 + cursor[2]) - #entry.regcontents[1],
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
    else
      for i, line in ipairs(entry.regcontents) do
        if i == 1 then
          table.insert(highlights, {
            row = cursor[1] - 1,
            col = cursor[2],
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
  elseif entry.regtype:find(keycode('<C-v>'), 1, true) then
    for i, line in ipairs(entry.regcontents) do
      table.insert(highlights, {
        row = cursor[1] + i - 2,
        col = cursor[2],
        end_col = cursor[2] + #line,
      })
    end
  end

  for _, hi in ipairs(highlights) do
    pcall(function()
      vim.api.nvim_buf_set_extmark(0, Highlight.ns.entry, hi.row, hi.col, {
        end_row = hi.row,
        end_col = hi.end_col,
        hl_group = 'PastaEntry',
        strict = false,
      })
    end)
  end
end

---Clear highlights.
function Highlight.clear()
  vim.api.nvim_buf_clear_namespace(0, Highlight.ns.cursor, 0, -1)
  vim.api.nvim_buf_clear_namespace(0, Highlight.ns.entry, 0, -1)
end

return Highlight
