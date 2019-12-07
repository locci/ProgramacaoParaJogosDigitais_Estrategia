
local hitDamage = 1
local fieldRadius = 100

return {
  name = "dengue",
  isDengue = true,
  solver = function(unit2, dist)
    if unit2:isMonster() then
      local dim = hitDamage
      if dist <= fieldRadius then
        unit2:dimHitDamage(dim)
      end
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 100,
  appearance = 'dengue',
  cost = 50,

  maxLevel = 2,
  level = 1,
  levelUpCost = 300,
  levelUp = function(level)
    local hit, hp, cost
    if level == 1 then
      hit = 5
      hp = 50
      cost = 130
    end
    return hit, hp, cost
  end
}
