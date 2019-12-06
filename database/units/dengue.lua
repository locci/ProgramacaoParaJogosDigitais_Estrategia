
hitDamage = 30
fieldRadius = 100

return {
  name = "dengue",
  isDengue = true,
  solver = function(unit2, dist)
    if unit2:isMonster() then
      dim = hitDamage
      if dist <= fieldRadius then
        unit2:dimHitDamage(dim)
      end
    end
  end,
  hitDamage,
  fieldRadius,
  max_hp = 100,
  appearance = 'dengue',
  cost = 50
}
