
local Unit = require 'common.class' ()

function Unit:_init(specname)
  local spec = require('database.units.' .. specname)
  self.spec = spec
  self.hp = spec.max_hp
  self.hitDamage = self.spec.hitDamage
end

function Unit:get_name()
  return self.spec.name
end

function Unit:reset(name, SpriteAtlas)
  local pos = self:getPos()
  self:_init(name)
  local app = self:get_appearance()
  if SpriteAtlas == nil then print("NUL:", name) end
  print(SpriteAtlas)
  SpriteAtlas:changeId(self, pos, app)
end

function Unit:get_appearance()
  return self.spec.appearance
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

function Unit:getPos()
  return self.pos
end

function Unit:setPos(pos)
  self.pos = pos
end

function Unit:dimHitDamage(dim)
  self.hitDamage = math.max(0, self.hitDamage - dim)
  print("dim", dim)
  print(self:get_name(), self.hitDamage)
end

function Unit:isMonster()
  return self.spec.isMonster
end

function Unit:isHero()
  return self.spec.isHero
end

function Unit:isHealer()
  return self.spec.isHealer
end

function Unit:isDengue()
  return self.spec.isDengue
end

function Unit:isDobby()
  return self.spec.isDobby
end

function Unit:changeHp(damage)
  local aux = math.min(self.spec.max_hp, self.hp - damage)
  self.hp = math.max(0, aux)
end

function Unit:getHitDamage()
  return self.spec.hitDamage
end

function Unit:getFieldRadius()
  if self.spec.fieldRadius then
    return self.spec.fieldRadius
  else
    return 0
  end
end

function Unit:setDrawCircle(drawCircle)
  self.drawCircle = drawCircle
end

function Unit:getDrawCircle()
  return self.drawCircle
end

function Unit:solve(unit2, dist, SpriteAtlas)
  if self.spec.solver then
    self.spec.solver(unit2, dist, SpriteAtlas)
  end
end

function Unit:levelUp()
  local hit, hp, cost = 0, 0, 0
  local level = self.spec.level

  if level + 1 <= self.spec.maxLevel then
    hit, hp, cost = self.spec.levelUp(level)
    self.spec.level = level + 1
  end
  print("depois", hit, hp, cost)
  self.spec.hitDamage = self.spec.hitDamage + hit
  self.spec.max_hp = self.spec.max_hp + hp
  self.spec.cost = self.spec.cost + cost
end

function Unit:getLevelUpCost()
  return self.spec.levelUpCost
end

function Unit:isMaxLevel()
  return (self.spec.level == self.spec.maxLevel)
end

return Unit
