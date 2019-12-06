
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
  cost = 1
}
