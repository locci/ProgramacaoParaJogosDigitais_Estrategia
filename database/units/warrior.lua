
hitDamage = 35
fieldRadius = 150

return {
  name = "Warrior Troop",
  isHero = true,
  solver = function(unit2, dist)
    if unit2:isMonster() and dist <= fieldRadius then
      unit2:changeHp(hitDamage)
    end
  end,
  hitDamage,
  fieldRadius,
  max_hp = 50,
  appearance = 'warrior',
  cost = 45
}
