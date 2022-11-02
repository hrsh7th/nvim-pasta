local LSP = require('pasta.kit.LSP')
local Buffer = require('pasta.kit.Vim.Buffer')

local Position = {}

---Return the value is position or not.
---@param v any
---@return boolean
function Position.is(v)
  return type(v) == 'table' and type(v.line) == 'number' and type(v.character) == 'number'
end

---Create cursor position.
---@param encoding pasta.kit.LSP.PositionEncodingKind
---@return pasta.kit.LSP.Position
function Position.cursor(encoding)
  encoding = encoding or LSP.PositionEncodingKind.UTF16
  local cursor = vim.api.nvim_win_get_cursor(0)
  local text = vim.api.nvim_get_current_line()

  local utf8 = { line = cursor[1] - 1, character = cursor[2] }
  if encoding == LSP.PositionEncodingKind.UTF8 then
    return utf8
  elseif encoding == LSP.PositionEncodingKind.UTF32 then
    return Position.to_utf32(text, utf8, LSP.PositionEncodingKind.UTF8)
  else
    return Position.to_utf16(text, utf8, LSP.PositionEncodingKind.UTF8)
  end
end

---Convert position to utf8 from specified encoding.
---@param expr string|integer
---@param position pasta.kit.LSP.Position
---@param from_encoding? pasta.kit.LSP.PositionEncodingKind
---@return pasta.kit.LSP.Position
function Position.to_vim(expr, position, from_encoding)
  if from_encoding == LSP.PositionEncodingKind.UTF8 then
    return position
  end
  local text = Buffer.at(expr, position.line)
  if from_encoding == LSP.PositionEncodingKind.UTF32 then
    return Position.to_utf8(text, position, LSP.PositionEncodingKind.UTF32)
  else
    return Position.to_utf8(text, position, LSP.PositionEncodingKind.UTF16)
  end
end

---Convert position to utf8 from specified encoding.
---@param text string
---@param position pasta.kit.LSP.Position
---@param from_encoding? pasta.kit.LSP.PositionEncodingKind
---@return pasta.kit.LSP.Position
function Position.to_utf8(text, position, from_encoding)
  from_encoding = from_encoding or LSP.PositionEncodingKind.UTF16

  if from_encoding == LSP.PositionEncodingKind.UTF8 then
    return position
  end

  local ok, byteindex = pcall(function()
    return vim.str_byteindex(text, position.character, from_encoding == LSP.PositionEncodingKind.UTF16)
  end)
  if not ok then
    return position
  end
  return { line = position.line, character = byteindex }
end

---Convert position to utf16 from specified encoding.
---@param text string
---@param position pasta.kit.LSP.Position
---@param from_encoding? pasta.kit.LSP.PositionEncodingKind
---@return pasta.kit.LSP.Position
function Position.to_utf16(text, position, from_encoding)
  local utf8 = Position.to_utf8(text, position, from_encoding)
  for index = utf8.character, 0, -1 do
    local ok, utf16index = pcall(function()
      return select(2, vim.str_utfindex(text, index))
    end)
    if ok then
      return { line = utf8.line, character = utf16index }
    end
  end
  return position
end

---Convert position to utf32 from specified encoding.
---@param text string
---@param position pasta.kit.LSP.Position
---@param from_encoding? pasta.kit.LSP.PositionEncodingKind
---@return pasta.kit.LSP.Position
function Position.to_utf32(text, position, from_encoding)
  local utf8 = Position.to_utf8(text, position, from_encoding)
  for index = utf8.character, 0, -1 do
    local ok, utf32index = pcall(function()
      return select(1, vim.str_utfindex(text, index))
    end)
    if ok then
      return { line = utf8.line, character = utf32index }
    end
  end
  return position
end

return Position
