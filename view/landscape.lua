--
-- Created by IntelliJ IDEA.
-- User: alexandre
-- Date: 20/11/2019
-- Time: 11:21
-- To change this template use File | Settings | File Templates.
--
local LANDSCAPE = {}

local land = {}

function LANDSCAPE:update()

   --local fase = 1
   --local num = math*random(fase + 5)
    local imag = sprite:makeQuad({2,4})
    table.insert(land, imag)



end

function LANDSCAPE:draw()

    local g = love.graphics
    g.draw(land[1], 50,50)

end

