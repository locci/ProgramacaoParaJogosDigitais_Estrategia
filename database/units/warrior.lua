
local hitDamage = 35
local fieldRadius = 150

return {
  name = "Warrior Troop",
  isHero = true,
  solver = function(unit2, dist)
    if unit2:isMonster() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 50,
  appearance = 'warrior',
  cost = 45,

  maxLevel = 3,
  level = 1,
  levelUpCost = 200,
  levelUp = function(level)
    local hit, hp, cost
    if level == 1 then
      hit = 15
      hp = 300
      cost = 100
    elseif level == 2 then
      hit = 40
      hp = 400
      cost = 300
    end
    return hit, hp, cost
  end
}
