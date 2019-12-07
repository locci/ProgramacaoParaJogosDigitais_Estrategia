
local hitDamage = 20
local fieldRadius = 100

return {
  name = "Druid",
  isMonster = true,
  solver = function(unit2, dist)
    if unit2:isHero() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 30,
  appearance = 'druid',
  cost = 20,
}
