-- luacheck: globals love
--
-- Created by IntelliJ IDEA.
-- User: alexandre
-- Date: 29/10/2019
-- Time: 19:03
-- To change this template use File | Settings | File Templates.
--

local SOUND = {}

local function auxPlay(arcName, vol, pitch)
  local name = "assets/sound/" .. arcName .. ".ogg"
  local src1 = love.audio.newSource(name, "static")
  src1:setVolume(vol)
  if pitch then src1:setPitch(pitch) end
  src1:play()
end

function SOUND.play(soundName, vol, pitch)
  auxPlay(soundName, vol, pitch)
end

return SOUND
