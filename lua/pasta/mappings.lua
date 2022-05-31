local pasta = require('pasta')

local mappings = {}

function mappings.p()
  pasta.start(true, false)
end

function mappings.P()
  pasta.start(false, true)
end

return mappings

