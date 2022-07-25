local converters = {}

---Adjust indentation
function converters.indentation(entry, context)
  if entry.regtype ~= 'V' then
    return entry
  end

  if not context.indent then
    return entry
  end

  local function remove_base_indent(contents)
    local min_indent
    for _, content in ipairs(contents) do
      if content ~= '' then
        local indent = string.match(content, '^%s*')
        if indent then
          if not min_indent then
            min_indent = indent
          else
            min_indent = #min_indent > #indent and indent or min_indent
          end
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
    if string.match(content, '^%s*$') then
      return ''
    end
    return context.indent.next .. content
  end, entry.regcontents)

  return entry
end

return converters

