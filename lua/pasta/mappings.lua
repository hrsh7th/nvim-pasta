local pasta = require('pasta')

local mappings = {}

function mappings.p()
  pasta.start(true)
end

function mappings.P()
  pasta.start(false)
end

return mappings

