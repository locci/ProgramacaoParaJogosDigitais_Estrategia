
local hitDamage = 0
local fieldRadius = 100

return {
  name = "dobby",
  isDobby = true,
  solver = function(unit2, dist)
    if unit2:isMonster() then
      if dist <= fieldRadius then
        if unit2:get_name() == "blue_slime" then
          unit2:reset("green_slime")
        end
      end
    end
  end,
  hitDamage = hitDamage,
  fieldRadius = fieldRadius,
  max_hp = 150,
  appearance = 'dobby',
  cost = 90
}
