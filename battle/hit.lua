local Hit = {}

local units = {}
local counter = 0
local delay = 3
local SpriteAtlas = nil

local function updateDamage(_)
  for _, unit1 in pairs(units) do
    for _, unit2 in pairs(units) do
      local dist = (unit1:getPos() - unit2:getPos()):length()

      if unit1:get_hp() > 0 and unit2:get_hp() > 0 then
        unit1:solve(unit2, dist, SpriteAtlas)
      end

    end
  end
end

function Hit.updateBattle(dt)
  --updateMove(dt)
  counter = counter + dt
  if counter >= delay then
    updateDamage(dt)
    counter = counter % delay
  end
end

function Hit.getStats(unitsInField, spriteAtlas)
  units = unitsInField
  SpriteAtlas = spriteAtlas
end

return Hit
