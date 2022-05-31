local Chars = {
  Next = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
  Prev = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
  Esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true),
}

local pasta = {}

pasta.history = {}

function pasta.save(regtype, regcontents)
  pasta.history = vim.tbl_filter(function(entry)
    return entry.regtype ~= regtype or table.concat(entry.regcontents, '\n') ~= table.concat(regcontents, '\n')
  end, pasta.history)
  table.insert(pasta.history, 1, {
    regtype = regtype,
    regcontents = regcontents
  })
end

function pasta.p()
  if #pasta.history == 0 then
    return
  end
  local restore = pasta.state()
  local index = 1
  pasta.paste(pasta.history[index], true, false)
  while true do
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char == Chars.Prev and index > 1 then
      index = index - 1
      restore()
      pasta.paste(pasta.history[index], true, false)
    elseif char == Chars.Next and index < #pasta.history then
      index = index + 1
      restore()
      pasta.paste(pasta.history[index], true, false)
    elseif char ~= Chars.Next and char ~= Chars.Prev then
      vim.api.nvim_input(char)
      break
    end
  end
end

function pasta.paste(entry, after, follow)
  vim.api.nvim_put(entry.regcontents, entry.regtype, after, follow)
  vim.cmd([[redraw!]])
end

function pasta.P()
  if #pasta.history == 0 then
    return
  end
  local entry = pasta.history[1]
  vim.api.nvim_put(table.concat(entry.regcontents, '\n'), entry.regtype, false, true)
end

function pasta.state()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local changenr = vim.fn.changenr()
  return function()
    vim.cmd(([[silent! undo %s]]):format(changenr))
    vim.api.nvim_win_set_cursor(0, cursor)
  end
end

return pasta

