
local COLLISION = {}

function COLLISION:checkCollision(posX , posY)

 local r = 0
 local catX = 0
 local catY = 0
 local soma = 0

 for _, j in pairs(_G.landscape) do
    if j['x'] ~= nil and j['y'] ~= nil then
       if math.floor(posX) == math.floor(j['x'])  and  math.floor(posY)  == math.floor(j['y'])  then
        return false
       end
    end

 end
    return true
end

return COLLISION