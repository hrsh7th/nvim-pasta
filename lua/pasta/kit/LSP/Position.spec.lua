local LSP = require('pasta.kit.LSP')
local Position = require('pasta.kit.LSP.Position')

describe('kit.LSP.Position', function()
  local text = '🗿🗿🗿'
  local utf8 = #text
  local utf16 = select(2, vim.str_utfindex(text, utf8))
  local utf32 = select(1, vim.str_utfindex(text, utf8))

  before_each(function()
    vim.cmd(([[
      enew!
      setlocal noswapfile
      setlocal virtualedit=onemore
      call setline(1, ['%s'])
    ]]):format(text))
  end)

  for _, from_encoding in ipairs({
    LSP.PositionEncodingKind.UTF16,
    LSP.PositionEncodingKind.UTF32,
  }) do
    it('should convert vim <- %s', function()
      vim.cmd([[normal! gg$]])
      local position = Position.cursor(from_encoding)
      assert.are_not.same(position, Position.cursor(LSP.PositionEncodingKind.UTF8))
      assert.are.same(Position.to_vim(0, position, from_encoding), Position.cursor(LSP.PositionEncodingKind.UTF8))
    end)
  end

  for _, to in ipairs({
    {
      method = 'to_utf8',
      encoding = LSP.PositionEncodingKind.UTF8,
      character = utf8,
    },
    {
      method = 'to_utf16',
      encoding = LSP.PositionEncodingKind.UTF16,
      character = utf16,
    },
    {
      method = 'to_utf32',
      encoding = LSP.PositionEncodingKind.UTF32,
      character = utf32,
    },
  }) do
    for _, from in ipairs({
      { character = utf8, encoding = LSP.PositionEncodingKind.UTF8 },
      { character = utf16, encoding = LSP.PositionEncodingKind.UTF16 },
      { character = utf32, encoding = LSP.PositionEncodingKind.UTF32 },
    }) do
      it(('should convert %s <- %s'):format(to.encoding, from.encoding), function()
        local converted = Position[to.method](text, { line = 1, character = from.character }, from.encoding)
        assert.are.same(to.character, converted.character)
      end)
    end
  end
end)
