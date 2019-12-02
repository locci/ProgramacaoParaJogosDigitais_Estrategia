
local COLLISION = {}

function COLLISION:checkCollision(posX , posY)

 local r = 0

 for _, j in pairs(_G.landscape) do

    if j['x'] ~= nil and j['y'] ~= nil then
       r = math.exp(math.exp(posX - j['x'], 2) + math.exp(posY - j['y'], 2), 0.5)
       if math.floor(posX ) == math.floor(j['x']) and math.floor(posY ) == math.floor(j['y']) then
         return false
       end
    end

 end
    return true
end

return COLLISION