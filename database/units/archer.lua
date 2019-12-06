
hitDamage = 30
fieldRadius = 300

return {
  name = "archer",
  isHero = true,
  solver = function(unit2, dist)
    if unit2:isMonster() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage,
  fieldRadius,
  max_hp = 80,
  appearance = 'archer',
  cost = 20
}
