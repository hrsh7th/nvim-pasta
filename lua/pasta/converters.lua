local converters = {}

---Adjust indentation
function converters.indentation(entry)
  if entry.regtype ~= 'V' then
    return entry
  end

  local function get_base_indent()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local curr_line = vim.api.nvim_buf_get_lines(0, cursor[1] - 1, cursor[1], false)[1]
    local next_line = vim.api.nvim_buf_get_lines(0, cursor[1], cursor[1] + 1, false)[1]

    local curr_indent = string.match(curr_line or '', '^%s*') or ''
    if not next_line or vim.api.nvim_get_mode().mode ~= 'n' then
      return curr_indent
    end

    local next_indent = string.match(next_line or '', '^%s*') or ''
    if #curr_indent > #next_indent then
      return curr_indent
    end
    return next_indent
  end

  local function remove_base_indent(contents)
    local min_indent
    for _, content in ipairs(contents) do
      local indent = string.match(content, '^%s*')
      if indent then
        if not min_indent then
          min_indent = indent
        else
          min_indent = #min_indent > #indent and indent or min_indent
        end
      end
    end
    min_indent = min_indent or ''

    return vim.tbl_map(function(content)
      return string.sub(content, #min_indent + 1)
    end, contents)
  end

  entry.regcontents = remove_base_indent(entry.regcontents)
  entry.regcontents = vim.tbl_map(function(content)
    return get_base_indent() .. content
  end, entry.regcontents)

  return entry
end

return converters

