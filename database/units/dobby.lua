
hitDamage = 0
fieldRadius = 100

return {
  name = "dobby",
  isDobby = true,
  solver = function(unit2, dist)
    if unit2:isMonster() then
      if dist <= unit1:getFieldRadius() then
        if unit2:get_name() == "blue_slime" then
          unit2:reset("green_slime")
        end
      end
    end
  end,
  hitDamage,
  fieldRadius,
  max_hp = 150,
  appearance = 'dobby',
  cost = 90
}
