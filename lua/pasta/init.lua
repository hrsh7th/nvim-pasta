local kit        = require('pasta.kit')
local Config     = require('pasta.kit.App.Config')
local converters = require('pasta.converters')
local highlight  = require('pasta.highlight')

---@class pasta.Entry
---@field public regtype string
---@field public regcontents string[]

---@class pasta.Context
---@field public indent? { curr: string, next: string }

---@class pasta.kit.App.Config.Schema
---@field public converters? (fun(entry: pasta.Entry, context: pasta.Context): pasta.Entry)[]
---@field public prevent_diagnostics? boolean
---@field public paste_mode? boolean
---@field public next_key? string
---@field public prev_key? string

local pasta      = {}

pasta.config     = Config.new({
  converters = {
    converters.indentation,
  },
  paste_mode = true,
  prevent_diagnostics = false,
  next_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
})

pasta.setup      = pasta.config:create_setup_interface()

---@type pasta.Entry
pasta.pin        = nil

---@type pasta.Entry[]
pasta.history    = {}

---@type boolean
pasta.running    = false

---Save yank history.
---@param regtype string
---@param regcontents string[]
function pasta.save(regtype, regcontents)
  if pasta.running then
    return
  end

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
function pasta.start(after)
  pasta.ensure()

  if #pasta.history == 0 and not pasta.pin then
    return
  end

  pasta.running = true

  local entries = kit.concat({}, pasta.history)
  if pasta.pin then
    entries = vim.tbl_filter(function(entry)
      return entry.regtype ~= pasta.pin.regtype or table.concat(entry.regcontents, '\n') ~= table.concat(pasta.pin.regcontents, '\n')
    end, entries)
    table.insert(entries, 1, pasta.pin)
  end

  local ok, err = pcall(function()
    if pasta.config:get().prevent_diagnostics then
      vim.diagnostic.disable()
    end
    local index = 1
    local entry = entries[index]
    local savepoint = pasta.savepoint()
    local context = pasta.context(savepoint, entry)
    pasta.paste(entry, after, context)
    while true do
      local char = vim.fn.nr2char(vim.fn.getchar())
      if char == pasta.config:get().prev_key and index > 1 then
        index = index - 1
        entry = entries[index]
        savepoint()
        pasta.paste(entry, after, context)
      elseif char == pasta.config:get().next_key and index < #entries then
        index = index + 1
        entry = entries[index]
        savepoint()
        pasta.paste(entry, after, context)
      elseif char ~= pasta.config:get().next_key and char ~= pasta.config:get().prev_key then
        vim.api.nvim_feedkeys(char, 'i', true)
        break
      end
    end
    pasta.save(entry.regtype, entry.regcontents)
    vim.fn.setreg(vim.v.register, entry)
  end)
  if not ok then
    print(err)
  end
  pasta.running = false
  highlight.clear()
  if pasta.config:get().prevent_diagnostics then
    vim.diagnostic.enable()
  end
end

---Pin or Unpin the current entry.
function pasta.toggle_pin()
  pasta.ensure()
  if pasta.pin then
    pasta.pin = nil
  else
    pasta.pin = pasta.history[1]
  end
end

---Paste the text and redraw.
---@param entry pasta.Entry
---@param after boolean
function pasta.paste(entry, after, context)
  -- clone & normalize
  entry = {
    regtype = entry.regtype,
    regcontents = { unpack(entry.regcontents) },
  }
  for _, converter in ipairs(pasta.config:get().converters or {}) do
    entry = converter(entry, context)
  end
  if entry.regtype ~= 'v' and #entry.regcontents > 1 and entry.regcontents[#entry.regcontents] == '' then
    table.remove(entry.regcontents, #entry.regcontents)
  end

  local paste = vim.o.paste
  local register = vim.fn.getreginfo(vim.v.register)
  vim.o.paste = pasta.config:get().paste_mode
  vim.fn.setreg(vim.v.register, entry)
  if after then
    vim.cmd('normal! p')
  else
    vim.cmd('normal! P')
  end
  vim.o.paste = paste
  vim.fn.setreg(vim.v.register, register)

  if vim.fn.reg_executing() == '' then
    highlight.cursor(vim.api.nvim_win_get_cursor(0))
    vim.cmd([[redraw!]])
  end
end

---Create savepoint.
---@return function
function pasta.savepoint()
  vim.o.undolevels = vim.o.undolevels
  local cursor = vim.fn.getcurpos()
  local changenr = vim.fn.changenr()
  local is_visual = pasta.is_visual()
  return function()
    if vim.fn.changenr() ~= changenr then
      vim.cmd(([[undo %s]]):format(changenr))
    end
    if is_visual then
      vim.cmd([[normal! gv]])
    end
    vim.fn.setpos('.', cursor)
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

---Create context.
---@param savepoint fun()
---@param entry pasta.Entry
---@return { indent?: { curr: string, next: string } }
function pasta.context(savepoint, entry)
  if vim.bo.indentexpr == '' then
    return {}
  end

  local curr_indent = string.match(vim.api.nvim_get_current_line(), '^%s+') or ''
  local first_line
  for _, line in ipairs(entry.regcontents) do
    if line ~= '' then
      first_line = line
      break
    end
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>o', true, true, true) .. first_line:gsub('^%s+', ''), 'nx', true)
  local next_indent = string.rep(' ', vim.api.nvim_eval(vim.bo.indentexpr))

  if not vim.bo.expandtab then
    next_indent = next_indent:gsub(string.rep(' ', vim.bo.shiftwidth ~= 0 and vim.bo.shiftwidth or vim.bo.tabstop), '\t')
  end

  local context = {
    indent = {
      curr = curr_indent,
      next = next_indent,
    },
  }
  savepoint()
  return context
end

---Return the mode is visual or not.
---@return boolean
function pasta.is_visual()
  return vim.tbl_contains({ 'v', 'V', vim.api.nvim_replace_termcodes('<C-v>', true, true, true) }, vim.api.nvim_get_mode().mode)
end

return pasta
