
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
  cost = 20
}
