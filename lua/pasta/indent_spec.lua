local Indent = require('pasta.indent')

describe('pasta.indent', function()
  it('should return correct adjusted text', function()
    vim.cmd([[
      set filetype=php
      set shiftwidth=2
      set tabstop=2
      set noexpandtab
    ]])

    assert.are.same(Indent.adjust({
      '		 * this is comment line.',
    }, ''), {
      ' * this is comment line.',
    })
  end)
end)
