local Cursor = require('pasta.cursor')

local Indent = {}

---Adjust the indent of the contents.
---@param contents string[]
---@param base string
function Indent.adjust(contents, base)
  -- detect min_indent.
  local one_indent = Indent.get_indent_text(1)
  local pattern = vim.regex(([[^\(%s\)*]]):format(vim.pesc(one_indent)))
  local min_indent = ''
  for _, content in ipairs(contents) do
    local s, e = pattern:match_str(content)
    if s and e then
      local curr_indent = content:sub(s + 1, e)
      if #min_indent == 0 or #curr_indent < #min_indent then
        min_indent = curr_indent
      end
    end
  end

  -- trim min_indent.
  if #min_indent > 0 then
    for i, content in ipairs(contents) do
      if content:match('^%s*$') then
        contents[i] = ''
      else
        contents[i] = content:gsub('^' .. min_indent, '')
      end
    end
  end

  -- add base indent.
  for i, content in ipairs(contents) do
    if content ~= '' then
      contents[i] = base .. content
    end
  end
  return contents
end

---Return the indent string.
function Indent.get_indent_text(count)
  local one_indent_text = (' '):rep(Indent.get_one_indent_width())
  local indent_text = (' '):rep(count * Indent.get_one_indent_width())
  if not vim.bo.expandtab then
    indent_text = indent_text:gsub(one_indent_text, '\t')
  end
  return indent_text
end

---Return one indent.
---@return integer
function Indent.get_one_indent_width()
  local width = vim.bo.shiftwidth or vim.o.shiftwidth
  if not width then
    width = vim.bo.tabstop or vim.o.tabstop
  end
  return width
end

---Return the indent width for the next new line.
---@param text? string
---@return integer
function Indent.get_next_indent_width(text)
  vim.v.lnum = vim.fn.line('.')
  local ok, width = false, nil
  Cursor.safe(function()
    local pos = vim.fn.getpos('.')
    local buf = vim.api.nvim_get_current_buf()
    vim.fn.appendbufline(buf, vim.fn.line('.'), text or '')
    pos[2] = pos[2] + 1
    vim.fn.setpos('.', pos)
    vim.v.lnum = vim.fn.line('.')
    ok, width = pcall(vim.fn.eval, vim.bo.indentexpr)
    vim.fn.deletebufline(buf, pos[2])
    width = (ok and width) or vim.fn.indent(vim.fn.line('.'))
  end)
  return width
end

---Return the indent count for the next new line.
---@param text? string
---@return integer
function Indent.get_next_indent_count(text)
  local width = Indent.get_next_indent_width(text)
  return math.floor(width / Indent.get_one_indent_width())
end

return Indent
