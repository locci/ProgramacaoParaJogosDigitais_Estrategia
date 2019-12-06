-- luacheck: globals love
--
-- Created by IntelliJ IDEA.
-- User: alexandre
-- Date: 29/10/2019
-- Time: 19:03
-- To change this template use File | Settings | File Templates.
--

local SOUND = {}

local function auxPlay(name, vol, pitch)
  local name = "assets/sound/" .. name .. ".ogg"
  local src1 = love.audio.newSource(name, "static")
  src1:setVolume(vol)
  if pitch then src1:setPitch(pitch) end
  src1:play()
end

function SOUND:play(soundName, vol, pitch)
  auxPlay(soundName, vol, pitch)
--[[
   if soundName == 'fail' then
       local src1 = love.audio.newSource("assets/sound/fail.ogg", "static")
       src1:setVolume(0.9)
       src1:play()
   end
   if soundName == 'monster' then
       local src1 = love.audio.newSource("assets/sound/monster.ogg", "static")
       src1:setVolume(0.9)
       --src1:setPitch(3)
       src1:play()
   end
   if soundName == 'coins' then
       local src1 = love.audio.newSource("assets/sound/coins.ogg", "static")
       src1:setVolume(0.4)
       src1:setPitch(3)
       src1:play()
   end
   if soundName == 'regmachine' then
       local src1 = love.audio.newSource("assets/sound/regmachine.ogg", "static")
       src1:setVolume(0.4) -- 90% of ordinary volume
       src1:setPitch(3) -- one octave lower
       src1:play()
   end

    if soundName == 'page' then
       print('oi')
       local src1 = love.audio.newSource("assets/sound/turnepage.ogg", "static")
       src1:setVolume(0.4) -- 90% of ordinary volume
       src1:setPitch(3) -- one octave lower
       src1:play()
    end

   if soundName == 'updown' then
       local src1 = love.audio.newSource("assets/sound/updown.ogg", "static")
       src1:setVolume(0.4) -- 90% of ordinary volume
       src1:setPitch(3) -- one octave lower
       src1:play()
   end

   if soundName == 'victory' then
       local src1 = love.audio.newSource("assets/sound/victory.ogg", "static")
       src1:setVolume(0.4) -- 90% of ordinary volume
       --src1:setPitch(3) -- one octave lower
       src1:play()
   end

   if soundName == 'charge' then
       local src1 = love.audio.newSource("assets/sound/charge.ogg", "static")
       src1:setVolume(0.4) -- 90% of ordinary volume
       --src1:setPitch(3) -- one octave lower
       src1:play()
   end

   if soundName == 'hit' then
      local src1 = love.audio.newSource("assets/sound/hitcapital.ogg", "static")
      src1:setVolume(0.4) -- 90% of ordinary volume
      src1:play()
   end

    if soundName == 'thema' then
           local src1 = love.audio.newSource("assets/sound/theme.ogg", "static")
           src1:setVolume(0.4) -- 90% of ordinary volume
           src1:play()
    end]]

end

return SOUND
