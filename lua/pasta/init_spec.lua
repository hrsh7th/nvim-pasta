local pasta = require('pasta')

describe('pasta', function()
  local function reset()
    vim.cmd([[
      bdelete!
      call setline(1, ['foo', 'bar', 'baz', ''])
    ]])
    vim.g.undolevels = vim.g.undolevels
    pasta.history = {}
    pasta.config.indent_fix = false
  end

  local check = function(entry, run_spec)
    -- native.
    reset()
    run_spec(function()
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
    run_spec(function()
      pasta.paste(entry, true, false)
    end, function()
      pasta.paste(entry, false, false)
    end)

    assert.are.same(state, {
      lines = vim.api.nvim_buf_get_lines(0, 0, -1, false),
      cursor = vim.fn.getcurpos(),
    })
  end

  local positions = {}
  -- normal.
  for _, lnum in ipairs({ 1, 2, 3, 4 }) do
    for col in ipairs({ 1, 2, 3, 4 }) do
      table.insert(positions, ('normal! %sG%s|'):format(lnum, col))
    end
  end
  -- visual
  for _, v in ipairs({ 'v', 'V', '' }) do
    for _, lnum in ipairs({ 1, 2, 3, 4 }) do
      for col in ipairs({ 1, 2, 3, 4 }) do
        for lnum_e = lnum, 4 do
          for col_e = col, 4 do
            table.insert(positions, ('normal! %sG%s|%s%sG%s|'):format(lnum, col, v, lnum_e, col_e))
          end
        end
      end
    end
  end

  for _, position in ipairs(positions) do
    for _, regcontents in ipairs({
      { '' },
      { '',     '' },
      { 'text' },
      { 'text', 'text' },
      { 'text', 'text', '' },
    }) do
      for _, regtype in ipairs({
        'v',
        'V',
        ''
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
