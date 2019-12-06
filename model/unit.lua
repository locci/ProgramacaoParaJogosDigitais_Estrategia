
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

function Unit:changeHp(damage)
  self.hp = math.max(0, self.hp - damage)
end

function Unit:get_hp()
  return self.hp, self.spec.max_hp
end

function Unit:set_color(color)
  self.spec.color = color
end

function Unit:get_cost()
  return self.spec.cost
end

function Unit:getPos(pos)
  return self.pos
end

function Unit:setPos(pos)
  self.pos = pos
end

function Unit:isMonster()
  return self.spec.isMonster
end

function Unit:isHero()
  return self.spec.isHero
end

function Unit:getHitDamage()
  return self.spec.hitDamage
end

function Unit:getFieldRadius()
  return self.spec.fieldRadius
end

return Unit
