local kit       = require('pasta.kit')
local Keymap    = require('pasta.kit.Vim.Keymap')
local Config    = require('pasta.kit.App.Config')
local highlight = require('pasta.highlight')
local indent    = require('pasta.indent')

---@class pasta.Entry
---@field public regtype string
---@field public regcontents string[]

---@class pasta.kit.App.Config.Schema
---@field public prevent_diagnostics? boolean
---@field public paste_mode? boolean
---@field public fix_cursor? boolean
---@field public fix_indent? boolean
---@field public next_key? string
---@field public prev_key? string

---@class pasta.Savepoint
---@field __call fun(): nil
---@field visualmode string

local pasta     = {}

pasta.config    = Config.new({
  fix_cursor = true,
  fix_indent = true,
  paste_mode = false,
  prevent_diagnostics = false,
  next_key = vim.api.nvim_replace_termcodes('<C-p>', true, true, true),
  prev_key = vim.api.nvim_replace_termcodes('<C-n>', true, true, true),
})

pasta.setup     = pasta.config:create_setup_interface()

---@type pasta.Entry
pasta.pin       = nil

---@type pasta.Entry[]
pasta.history   = {}

---@type boolean
pasta.running   = false

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

  local cursor_blend = vim.api.nvim_get_hl(0, { name = 'Cursor' }).blend
  if pasta.config:get().fix_cursor then
    vim.cmd('hi Cursor blend=100')
    vim.cmd('set guicursor+=a:Cursor')
  end

  local ok, err = pcall(function()
    if pasta.config:get().prevent_diagnostics then
      vim.diagnostic.disable()
    end
    local index = 1
    local entry = entries[index]
    local savepoint = pasta.savepoint()
    pasta.paste(entry, after, savepoint)
    while true do
      vim.cmd([[redraw]])
      local char = vim.fn.nr2char(vim.fn.getchar())
      if char == pasta.config:get().prev_key and index > 1 then
        index = index - 1
        entry = entries[index]
        savepoint()
        pasta.paste(entry, after, savepoint)
      elseif char == pasta.config:get().next_key and index < #entries then
        index = index + 1
        entry = entries[index]
        savepoint()
        pasta.paste(entry, after, savepoint)
      elseif char ~= pasta.config:get().next_key and char ~= pasta.config:get().prev_key then
        vim.api.nvim_feedkeys(char, 'i', true)
        break
      end
    end
    pasta.save(entry.regtype, entry.regcontents)
    vim.fn.setreg(vim.v.register, entry)
  end)

  if pasta.config:get().fix_cursor then
    vim.cmd(('hi Cursor blend=%s'):format(cursor_blend))
    vim.cmd('set guicursor+=a:Cursor')
  end

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

---Paste the text.
---@param entry pasta.Entry
---@param after boolean
---@param savepoint pasta.Savepoint
function pasta.paste(entry, after, savepoint)
  -- clone & normalize
  entry = {
    regtype = entry.regtype,
    regcontents = { unpack(entry.regcontents) },
  }
  if entry.regtype ~= 'v' and #entry.regcontents > 1 and entry.regcontents[#entry.regcontents] == '' then
    table.remove(entry.regcontents, #entry.regcontents)
  end

  local paste = vim.o.paste
  vim.o.paste = pasta.config:get().paste_mode

  if pasta.config:get().fix_indent and entry.regtype == 'V' and (savepoint.visualmode == 'V' or savepoint.visualmode == '') then
    local keys = ''
    if savepoint.visualmode == 'V' then
      keys = keys .. '"_dk'
    end
    keys = keys .. (after and 'o' or 'O') .. vim.keycode('_<Esc>==')
    keys = keys .. Keymap.to_sendable(function()
      local i = vim.api.nvim_get_current_line():match('^(%s*)')
      entry.regcontents = indent.trim(entry.regcontents)
      entry.regcontents = kit.map(entry.regcontents, function(line)
        return i .. line
      end)
      vim.fn.setreg(vim.v.register, entry)
      vim.cmd('normal! ' .. (after and 'pk"_dd' or '"_ddP'))
    end)
    vim.api.nvim_feedkeys(keys, 'nx', true)
  else
    vim.fn.setreg(vim.v.register, entry)
    vim.api.nvim_feedkeys((after and 'p' or 'P'), 'nx', true)
  end

  vim.o.paste = paste

  if vim.fn.reg_executing() == '' then
    pcall(function()
      local cursor = vim.api.nvim_win_get_cursor(0)
      highlight.entry(cursor, entry)
      highlight.cursor(cursor)
    end)
  end
end

---Create savepoint.
---@return pasta.Savepoint
function pasta.savepoint()
  vim.o.undolevels = vim.o.undolevels
  local cursor = vim.fn.getcurpos()
  local changenr = vim.fn.changenr()
  local visualmode = pasta.is_visual() and vim.fn.visualmode() or ''
  local view = vim.fn.winsaveview()
  local s, e
  if visualmode ~= '' then
    vim.cmd([[normal! o]])
    e = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[normal! o]])
    s = vim.api.nvim_win_get_cursor(0)
  end
  return setmetatable({
    visualmode = visualmode,
  }, {
    __call = function()
      if vim.fn.changenr() ~= changenr then
        vim.cmd(([[undo %s]]):format(changenr))
      end
      if visualmode ~= '' then
        vim.cmd(('normal! %sG%s|v%sG%s|'):format(s[1], s[2] + 1, e[1], e[2] + 1))
      end
      vim.fn.setpos('.', cursor)
      vim.fn.winrestview(view)
    end
  })
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

---Return the mode is visual or not.
---@return boolean
function pasta.is_visual()
  return vim.tbl_contains({ 'v', 'V', vim.api.nvim_replace_termcodes('<C-v>', true, true, true) }, vim.api.nvim_get_mode().mode)
end

return pasta
