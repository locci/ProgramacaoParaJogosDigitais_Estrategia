
local hitDamage = 15
local fieldRadius = 50

return {
    name = "Blue Slime",
    isMonster = true,
    solver = function(unit2, dist)
      if unit2:isHero() and dist <= fieldRadius then
        unit2:changeHp(hitDamage)
      end
    end,
    hitDamage = hitDamage,
    fieldRadius = fieldRadius,
    max_hp = 4,
    appearance = 'blue_slime',
    cost = 30,
    
}
