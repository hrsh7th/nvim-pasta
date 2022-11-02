local AsyncTask = require('pasta.kit.Async.AsyncTask')

_G.__kit__ = _G.__kit__ or {}
_G.__kit__.Async = _G.__kit__.Async or {}
_G.__kit__.Async.threads = _G.__kit__.Async.threads or {}

local Async = {}

---Run async function immediately.
---@param runner fun()
---@param ... any
---@return pasta.kit.Async.AsyncTask
function Async.run(runner, ...)
  return Async.async(runner)(...)
end

---Create async function.
---@param runner fun()
---@return fun(): pasta.kit.Async.AsyncTask
function Async.async(runner)
  return function(...)
    local args = { ... }
    return AsyncTask.new(function(resolve, reject)
      local thread = coroutine.create(runner)
      _G.__kit__.Async.threads[thread] = true
      local function next_step(ok, v)
        if coroutine.status(thread) == 'dead' then
          _G.__kit__.Async.threads[thread] = nil
          if not ok then
            return reject(v)
          end
          return AsyncTask.resolve(v):next(resolve):catch(reject)
        end

        AsyncTask.resolve(v)
          :next(function(...)
            next_step(coroutine.resume(thread, ...))
          end)
          :catch(function(...)
            next_step(coroutine.resume(thread, ...))
          end)
      end
      next_step(coroutine.resume(thread, unpack(args)))
    end)
  end
end

---Await async task.
---@param task pasta.kit.Async.AsyncTask
---@return any
function Async.await(task)
  if not _G.__kit__.Async.threads[coroutine.running()] then
    error('`Async.await` must be called in async function.')
  end
  return coroutine.yield(AsyncTask.resolve(task))
end

return Async
