
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
  cost = 50
}
