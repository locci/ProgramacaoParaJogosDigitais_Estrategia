local Hit = {}
local CIRCLEFIELD = require 'battle.circlefield'

local units = {}
local counter = 0
local delay = 1

function Hit:updateBattle(dt)
  --updateMove(dt)
  counter = counter + dt
  if counter >= delay then
    updateDamage(dt)
    updateImages(dt)
    counter = counter % delay
  end
end

function updateDamage(dt)
  for _, unit1 in pairs(units) do
    for _, unit2 in pairs(units) do
      if unit1:isHero() and unit2:isMonster() or
      unit2:isHero() and unit1:isMonster() then
        local dist = (unit1:getPos() - unit2:getPos()):length()
        if dist <= unit1:getFieldRadius() then
          --porradaria franca
          if unit2:get_hp() > 0 then
            unit2:changeHp(unit1:getHitDamage())
          end
          print("unit1=", unit1:get_name(), unit1:get_hp())
          print("\nunit2=", unit2:get_name(), unit2:get_hp())
        end
      end
      if unit1:isHealer() and unit2:isHero() then
        unit2:changeHp(unit1:getHitDamage())
        print("\nunit2=", unit2:get_name(), unit2:get_hp())
      elseif unit2:isHealer() and unit1:isHero() then
        --print("\nunit1=", unit1:get_name(), unit1:get_hp())
        unit1:changeHp(unit2:getHitDamage())
      end
    end
  end
end

-- Se morrer, tirar da tela (p ex)
function updateImages(dt)

end

function Hit.getStats(unitsInField)
  units = unitsInField
end

return Hit
