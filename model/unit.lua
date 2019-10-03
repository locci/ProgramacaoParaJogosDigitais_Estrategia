
local Unit = require 'common.class' ()

function Unit:_init(specname)
  local spec = require('database.units.' .. specname)
  self.spec = spec
  self.hp = spec.max_hp
end

function Unit:get_name()
  return self.spec.name
end

function Unit:get_appearance()
  return self.spec.appearance
end

function Unit:get_hp()
  return self.hp, self.spec.max_hp
end

return Unit

