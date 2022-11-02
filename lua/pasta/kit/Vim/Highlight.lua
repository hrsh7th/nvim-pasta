local kit = require('pasta.kit')
local Async = require('pasta.kit.Async')
local AsyncTask = require('pasta.kit.Async.AsyncTask')

local Highlight = {}

Highlight.namespace = vim.api.nvim_create_namespace('pasta.kit.Vim.Highlight')

---Blink specified range.
---@param range pasta.kit.LSP.Range
---@param option? { delay: integer, count: integer }
---@return pasta.kit.Async.AsyncTask
function Highlight.blink(range, option)
  option = kit.merge(option or {}, {
    delay = 150,
    count = 2,
  })

  local function timeout(time)
    return AsyncTask.new(function(resolve)
      vim.defer_fn(vim.schedule_wrap(resolve), time)
    end)
  end

  return Async.run(function()
    Async.await(timeout(option.delay * 1.2))
    for _ = 1, option.count do
      vim.highlight.range(0, Highlight.namespace, 'IncSearch', { range.start.line, range.start.character }, { range['end'].line, range['end'].character }, {})
      Async.await(timeout(option.delay * 0.8))
      vim.api.nvim_buf_clear_namespace(0, Highlight.namespace, 0, -1)
      Async.await(timeout(option.delay))
    end
  end)
end

return Highlight
