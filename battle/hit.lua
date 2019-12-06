local Hit = {}
local CIRCLEFIELD = require 'battle.circlefield'

local units = {}
local counter = 0
local delay = 3

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
      local dist = (unit1:getPos() - unit2:getPos()):length()

      if unit1:get_hp() > 0 then
        unit1:solve(unit2, dist)
      end
      --[[if unit1:isHero() and unit2:isMonster() then
        if dist <= unit1:getFieldRadius() then
          --porradaria franca
          if unit2:get_hp() > 0 and unit1:get_hp() > 0 then
            unit2:changeHp(unit1:getHitDamage())
            print("unit1=", unit1:get_name(), unit1:get_hp())
            print("\nunit2=", unit2:get_name(), unit2:get_hp())
          end
        end
      elseif unit2:isHero() and unit1:isMonster() then
        if dist <= unit1:getFieldRadius() then
          --porradaria franca
          if unit2:get_hp() > 0 and unit1:get_hp() > 0 then
            unit2:changeHp(unit1:getHitDamage())
            print("unit1=", unit1:get_name(), unit1:get_hp())
            print("\nunit2=", unit2:get_name(), unit2:get_hp())
          end
        end
      end
      if unit1:isHealer() and unit2:isHero() then
        if dist <= unit1:getFieldRadius() then
          unit2:changeHp(unit1:getHitDamage())
          print("\nunit2=", unit2:get_name(), unit2:get_hp())
        end
      elseif unit2:isHealer() and unit1:isHero() then
        if dist <= unit2:getFieldRadius() then
          unit1:changeHp(unit2:getHitDamage())
        end
      end

      -- diminui a força
      local dim
      if unit1:isDengue() and unit2:isMonster() then
        dim = unit1:getHitDamage()
        if dist <= unit1:getFieldRadius() then
          unit2:dimHitDamage(dim)
        end
      elseif unit2:isDengue() and unit1:isMonster() then
        dim = unit2:getHitDamage()
        if dist <= unit2:getFieldRadius() then
          print("dengue", unit1:get_name())
          unit1:dimHitDamage(dim)
        end
      end

      -- troca a identidade dos outros
      if unit1:isDobby() and unit2:isMonster() then
        if dist <= unit1:getFieldRadius() then
          if unit2:get_name() == "blue_slime" then
            unit2:reset("green_slime")
          end
        end
      elseif unit2:isDobby() and unit1:isMonster() then
        if dist <= unit2:getFieldRadius() then
          if unit1:get_name() == "blue_slime" then
            unit1:reset("green_slime")
          end
        end
      end]]

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
