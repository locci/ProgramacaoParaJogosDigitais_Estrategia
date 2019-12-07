
local hitDamage = 30
local fieldRadius = 100

return {
  name = "archer",
  isHero = true,
  solver = function(unit2, dist)
    if unit2:isMonster() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 80,
  appearance = 'archer',
  cost = 20,

  maxLevel = 3,
  level = 1,
  levelUpCost = 100,
  levelUp = function(level)
    local hit, hp, cost
    if level == 1 then
      hit = 10
      hp = 20
      cost = 10
    elseif level == 2 then
      hit = 20
      hp = 30
      cost = 40
    end
    return hit, hp, cost
  end
}
