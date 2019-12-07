
local hitDamage = 10
local fieldRadius = 30

return {
  name = "Priest",
  isMonster = true,
  solver = function(unit2, dist)
    if unit2:isHero() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 50,
  appearance = 'priest',
  cost = 30,
}
