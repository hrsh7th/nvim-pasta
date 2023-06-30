local indent = {}

---@param contents string[]
function indent.trim(contents)
  local min_indent = ''
  for _, content in ipairs(contents) do
    local curr_indent = content:match('^(%s*)')
    if curr_indent then
      if #min_indent == 0 or #curr_indent < #min_indent then
        min_indent = curr_indent
      end
    end
  end

  if #min_indent > 0 then
    for i, content in ipairs(contents) do
      contents[i] = content:gsub('^' .. min_indent, '')
    end
  end

  return contents
end

return indent
