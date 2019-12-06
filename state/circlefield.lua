
local CIRCLEFIELD = {}

function CIRCLEFIELD:checkCollision(posX , posY)

 for _, j in pairs(_G.landscape) do
    if j['x'] ~= nil and j['y'] ~= nil then
       if math.floor(posX) == math.floor(j['x'])  and  math.floor(posY)  == math.floor(j['y'])  then
        return false
       end
    end
 end
    return true
end


return CIRCLEFIELD
