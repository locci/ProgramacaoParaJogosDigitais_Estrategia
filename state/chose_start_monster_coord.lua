--
-- Created by IntelliJ IDEA.
-- User: alexandre
-- Date: 24/11/2019
-- Time: 10:27
-- To change this template use File | Settings | File Templates.
--

local CHOOSESTARTCOORD = {}

math.randomseed(os.time())

function CHOOSESTARTCOORD:origen_coord(x, y)

    local orin  = math.random(100)
    if orin < 25 then
        x = math.random(-7,7)
        y = -7
        return x, y
    end
    if orin < 50 then
        x = math.random(-7,7)
        y = 7
        return x, y
    end
    if orin < 75 then
        y = math.random(-7,7)
        x = 7
        return x, y
    end
    y = math.random(-7,7)
    x = -7
    return x, y
end

return CHOOSESTARTCOORD

