
local hitDamage = 0
local fieldRadius = 100

return {
  name = "dobby",
  isDobby = true,
  solver = function(unit2, dist, SpriteAtlas)
    if unit2:isMonster() then
      if dist <= fieldRadius then
        if unit2:get_appearance() == "blue_slime" then
          print("dobby", SpriteAtlas)
          unit2:reset("green_slime", SpriteAtlas)
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
