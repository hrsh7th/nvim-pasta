local Entry = require('pasta.entry')
local Cursor = require('pasta.cursor')
local Indent = require('pasta.indent')
local Highlight = require('pasta.highlight')
local SideEffect = require('pasta.side_effect')
local VisualMode = require('pasta.visual_mode')

---@class pasta.Entry
---@field regtype string
---@field regcontents string[]

local config = {
  next_key = vim.keycode('<C-n>'),
  prev_key = vim.keycode('<C-p>'),
  indent_key = vim.keycode(','),
  indent_fix = true,
}

---@class pasta
---@field history pasta.Entry[]
local pasta = {
  running = false,
  history = {},
  config = config,
}

---Handle on_text_yank_post.
---@param e { regtype: string, regcontents: string[] }
function pasta.add_entry(e)
  if pasta.running then
    return
  end

  table.insert(pasta.history, 1, {
    regtype = e.regtype,
    regcontents = e.regcontents
  })
  pasta.history = vim.iter(pasta.history):filter(function(entry)
    if pasta.history[1] == entry then
      return true
    end
    return not Entry.is_same(pasta.history[1], entry)
  end):totable()
end

---Paste entry.
---@param entry pasta.Entry
---@param after boolean
---@param indent_fix boolean
function pasta.paste(entry, after, indent_fix)
  entry = Entry.clone(entry)

  -- fix linewise register.
  if entry.regtype == 'V' or entry.regtype == '' then
    if entry.regcontents[#entry.regcontents] == '' then
      if #entry.regcontents > 1 then
        table.remove(entry.regcontents, #entry.regcontents)
      end
    end
  end

  -- adjust indentation.
  if indent_fix then
    if entry.regtype == 'V' then
      entry.regcontents = Indent.adjust(
        entry.regcontents,
        Indent.get_indent_text(Indent.get_next_indent_count(entry.regcontents[1]))
      )
    end
  end

  -- save visual mode type before paste.
  local visual = VisualMode.visual()

  -- paste.
  local saved_reg = vim.fn.getreg('x')
  vim.fn.setreg('x', entry)
  vim.api.nvim_feedkeys('"' .. 'x' .. (after and 'p' or 'P'), 'nix', true)
  vim.fn.setreg('x', saved_reg)

  -- highlight pseudo cursor and pasted region.
  Highlight.set(vim.api.nvim_win_get_cursor(0), entry, visual)
end

---Start pasting mode.
---@param after boolean
function pasta.start(after)
  local head_reg = vim.fn.getreginfo(vim.v.register)
  if not Entry.is_same(pasta.history[1], head_reg) then
    pasta.add_entry(head_reg)
  end

  pasta.running = true

  local savepoint = pasta.savepoint()
  SideEffect.prevent(function()
    Cursor.hide(function()
      local state = {
        index = 1,
        updated = false,
        indent_fix = config.indent_fix,
      }

      while true do
        if not state.updated then
          pasta.paste(pasta.history[state.index], after, state.indent_fix)
          vim.cmd.redraw()
          state.updated = true
        end

        local char = vim.fn.nr2char(vim.fn.getchar())
        if char == config.next_key then
          local index = math.min(state.index + 1, #pasta.history)
          if index ~= state.index then
            state.index = index
            state.updated = false
            savepoint()
          end
        elseif char == config.prev_key then
          local index = math.max(state.index - 1, 1)
          if index ~= state.index then
            state.index = index
            state.updated = false
            savepoint()
          end
        elseif char == config.indent_key then
          state.indent_fix = not state.indent_fix
          state.updated = false
        else
          vim.api.nvim_feedkeys(char, 'ni', true)
          break
        end
      end
    end)
  end)

  Highlight.clear()
  pasta.running = false
end

function pasta.savepoint()
  vim.g.undolevels = vim.g.undolevels
  local changenr = vim.fn.changenr()
  local curpos = vim.fn.getpos('.')
  local visual = VisualMode.savepoint()
  local view = vim.fn.winsaveview() ---@type any
  return function()
    if vim.fn.changenr() ~= changenr then
      vim.cmd(([[undo %s]]):format(changenr))
    end
    visual()
    vim.fn.setpos('.', curpos)
    vim.fn.winrestview(view)
  end
end

return pasta
