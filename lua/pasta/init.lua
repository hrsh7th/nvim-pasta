local converters = require('pasta.converters')
local highlight  = require('pasta.highlight')

---@class pasta.Entry
---@field public regtype string
---@field public regcontents string[]

---@class pasta.Config
---@field public converters? (fun(entry: pasta.Entry): pasta.Entry)[]
---@field public paste_mode? boolean
---@field public next_key? string
---@field public prev_key? string

local config = {
  converters = {
    converters.indentation,
  },
  paste_mode = true,
  next_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
}

local pasta = {}

---@type pasta.Entry[]
pasta.history = {}

---Setup pasta.
---@param config_ pasta.Config
function pasta.setup(config_)
  for k, v in pairs(config_) do
    config[k] = v
  end
end

---Save yank history.
---@param regtype string
---@param regcontents string[]
function pasta.save(regtype, regcontents)
  pasta.history = vim.tbl_filter(function(entry)
    return entry.regtype ~= regtype or table.concat(entry.regcontents, '\n') ~= table.concat(regcontents, '\n')
  end, pasta.history)
  table.insert(pasta.history, 1, {
    regtype = regtype,
    regcontents = regcontents
  })
end

---Start paste mode.
---@param after boolean
---@param follow boolean
function pasta.start(after, follow)
  pasta.ensure()

  if #pasta.history == 0 then
    return
  end

  vim.diagnostic.disable()
  local savepoint = pasta.savepoint()
  local index = 1
  pasta.paste(pasta.history[index], after, follow)
  while true do
    local char = vim.fn.nr2char(vim.fn.getchar())
    if char == config.prev_key and index > 1 then
      index = index - 1
      savepoint()
      pasta.paste(pasta.history[index], after, follow)
    elseif char == config.next_key and index < #pasta.history then
      index = index + 1
      savepoint()
      pasta.paste(pasta.history[index], after, follow)
    elseif char ~= config.next_key and char ~= config.prev_key then
      vim.api.nvim_feedkeys(char, 'i', true)
      break
    end
  end
  highlight.clear()
  vim.diagnostic.enable()
end

---Paste the text and redraw.
---@param entry pasta.Entry
---@param after boolean
---@param follow boolean
function pasta.paste(entry, after, follow)
  for _, converter in ipairs(config.converters or {}) do
    entry = converter(entry)
  end

  local paste = vim.o.paste
  vim.o.paste = config.paste_mode
  vim.api.nvim_put(entry.regcontents, entry.regtype, after, follow)
  vim.o.paste = paste
  highlight.cursor(vim.api.nvim_win_get_cursor(0))
  vim.cmd([[redraw!]])
end

---Create savepoint.
---@return function
function pasta.savepoint()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local changenr = vim.fn.changenr()
  return function()
    vim.cmd(([[noautocmd silent! undo %s]]):format(changenr))
    vim.api.nvim_win_set_cursor(0, cursor)
  end
end

---Ensure recent register.
function pasta.ensure()
  for _, register in ipairs({ vim.v.register }) do
    local reginfo = vim.fn.getreginfo(register)
    if not vim.tbl_isempty(reginfo) then
      pasta.save(reginfo.regtype, reginfo.regcontents)
    end
  end
end

return pasta

