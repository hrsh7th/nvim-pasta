local pasta = require('pasta')

describe('pasta', function()

  local function reset()
    vim.cmd([[
      bdelete!
      call setline(1, ['foo', 'bar', 'baz', ''])
    ]])
    pasta.setup {
      fix_indent = false,
    }
  end

  local check = function(entry, prepare)
    -- native.
    reset()
    prepare(function()
      vim.fn.setreg(vim.v.register, table.concat(entry.regcontents, '\n'), entry.regtype)
      vim.cmd('normal! p')
    end, function()
      vim.fn.setreg(vim.v.register, table.concat(entry.regcontents, '\n'), entry.regtype)
      vim.cmd('normal! P')
    end)
    local state = {
      lines = vim.api.nvim_buf_get_lines(0, 0, -1, false),
      cursor = vim.fn.getcurpos(),
    }

    -- pasta.
    reset()
    prepare(function()
      pasta.paste(entry, true)
    end, function()
      pasta.paste(entry, false)
    end)

    assert.are.same(state, {
      lines = vim.api.nvim_buf_get_lines(0, 0, -1, false),
      cursor = vim.fn.getcurpos(),
    })
  end

  for _, position in ipairs({
    'normal! 1G1|',
    'normal! 1G2|',
    'normal! 1G3|',
    'normal! 2G1|',
    'normal! 2G2|',
    'normal! 2G3|',
    'normal! 3G1|',
    'normal! 3G2|',
    'normal! 3G3|',
    'normal! 4G1|',
    'normal! 4G1|',
    'normal! 1GV',
    'normal! 2GV',
    'normal! 3GV',
    'normal! 4GV',
    'normal! 1GVj',
    'normal! 2GVj',
    'normal! 3GVj',
    'normal! 1G1|v3|',
    'normal! 2G1|v3|',
    'normal! 4G1|v3|',
    'normal! 4Gv',
  }) do
    for _, regcontents in ipairs({
      { '' },
      { '', '' },
      { 'text' },
      { 'text', 'text' },
      { 'text', 'text', '' },
    }) do
      for _, regtype in ipairs({
        'v',
        'V',
        vim.api.nvim_replace_termcodes('<C-v>', true, true, true),
      }) do
        it(('should be the same as native (p: %s)'):format(vim.inspect({
          position = position,
          regtype = regtype,
          regcontents = regcontents,
        })), function()
          check({
            regtype = regtype,
            regcontents = regcontents,
          }, function(p, _)
            vim.cmd(position)
            p()
          end)
        end)

        it(('should be the same as native (P: %s)'):format(vim.inspect({
          position = position,
          regtype = regtype,
          regcontents = regcontents,
        })), function()
          check({
            regtype = regtype,
            regcontents = regcontents,
          }, function(_, P)
            vim.cmd(position)
            P()
          end)
        end)
      end
    end
  end
end)
