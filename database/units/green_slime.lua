
local hitDamage = 10
local fieldRadius = 100

return {
  name = "Green Slime",
  isMonster = true,
  solver = function(unit2, dist)
    if unit2:isHero() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 4,
  appearance = 'green_slime',
  cost = 15,
}
