
hitDamage = -10
fieldRadius = 200

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
  hitDamage,
  fieldRadius,
  max_hp = 1000,
  appearance = 'healer',
  cost = 1
}
