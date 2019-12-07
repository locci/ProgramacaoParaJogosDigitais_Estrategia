
local hitDamage = -10
local fieldRadius = 200

return {
  name = "healer",
  isHealer = true,
  solver = function(unit2, dist)
    if unit2:isHero() then
      if dist <= fieldRadius then
        unit2:changeHp(hitDamage)
      end
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 1000,
  appearance = 'healer',
  cost = 100,

  maxLevel = 3,
  level = 1,
  levelUpCost = 500,
  levelUp = function(level)
    local hit, hp, cost
    if level == 1 then
      hit = -20
      hp = 300
      cost = 100
    elseif level == 2 then
      hit = -30
      hp = 400
      cost = 200
    end
    return hit, hp, cost
  end
}
