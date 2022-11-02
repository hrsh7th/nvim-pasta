local kit = require('pasta.kit')
local Cache = require('pasta.kit.Cache')


---@alias pasta.kit.Config.SchemaInternal pasta.kit.Config.Schema|{ revision: integer }

---@class pasta.kit.Config
---@field private _cache pasta.kit.Cache
---@field private _default pasta.kit.Config.SchemaInternal
---@field private _global pasta.kit.Config.SchemaInternal
---@field private _filetype table<string, pasta.kit.Config.SchemaInternal>
---@field private _buffer table<integer, pasta.kit.Config.SchemaInternal>
local Config = {}

---Create new config instance.
---@param default? pasta.kit.Config.Schema
function Config.new(default)
  local self = setmetatable({}, { __index = Config })
  self._cache = Cache.new()
  self._default = default or {}
  self._global = {}
  self._filetype = {}
  self._buffer = {}
  return self
end

---Set default configuration.
---@param default pasta.kit.Config.Schema
function Config:default(default)
  self._default = default
end

---Update global config.
---@param config pasta.kit.Config.Schema
function Config:global(config)
  local revision = (self._global.revision or 1) + 1
  self._global = config or {}
  self._global.revision = revision
end

---Update filetype config.
---@param filetypes string|string[]
---@param config pasta.kit.Config.Schema
function Config:filetype(filetypes, config)
  for _, filetype in ipairs(kit.to_array(filetypes)) do
    local revision = ((self._filetype[filetype] or {}).revision or 1) + 1
    self._filetype[filetype] = config or {}
    self._filetype[filetype].revision = revision
  end
end

---Update filetype config.
---@param bufnr integer
---@param config pasta.kit.Config.Schema
function Config:buffer(bufnr, config)
  bufnr = bufnr == 0 and vim.api.nvim_get_current_buf() or bufnr
  local revision = ((self._buffer[bufnr] or {}).revision or 1) + 1
  self._buffer[bufnr] = config or {}
  self._buffer[bufnr].revision = revision
end

---Create setup interface.
---@return fun(config: pasta.kit.Config.Schema)|{ filetype: fun(filetypes: string|string[], config: pasta.kit.Config.Schema), buffer: fun(bufnr: integer, config: pasta.kit.Config.Schema) }
function Config:create_setup_interface()
  return setmetatable({}, {
    ---@param config pasta.kit.Config.Schema
    __call = function(_, config)
      self:global(config)
    end,
    ---@param filetypes string|string[]
    ---@param config pasta.kit.Config.Schema
    filetype = function(_, filetypes, config)
      self:filetype(filetypes, config)
    end,
    ---@param bufnr integer
    ---@param config pasta.kit.Config.Schema
    buffer = function(_, bufnr, config)
      self:buffer(bufnr, config)
    end,
  })
end

---Get current configuration.
---@return pasta.kit.Config.Schema
function Config:get()
  local filetype = vim.api.nvim_buf_get_option(0, 'filetype')
  local bufnr = vim.api.nvim_get_current_buf()
  return self._cache:ensure({
    self._global.revision or 0,
    (self._buffer[bufnr] or {}).revision or 0,
    (self._filetype[filetype] or {}).revision or 0,
  }, function()
    local config = self._default
    config = kit.merge(self._global, config)
    config = kit.merge(self._filetype[filetype] or {}, config)
    config = kit.merge(self._buffer[bufnr] or {}, config)
    config.revision = nil
    return config
  end)
end

return Config
