--
-- Created by IntelliJ IDEA.
-- User: alexandre
-- Date: 25/11/2019
-- Time: 19:14
-- To change this template use File | Settings | File Templates.
--

local CHECKKILL = {}

function CHECKKILL.check_kill(num)

    if math.fmod(num,3) == 0 then return true end
    return false

end


return CHECKKILL
