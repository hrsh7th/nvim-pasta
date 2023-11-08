local mapping = {}

function mapping.p()
  require('pasta').start(true)
end

function mapping.P()
  require('pasta').start(false)
end

return mapping
