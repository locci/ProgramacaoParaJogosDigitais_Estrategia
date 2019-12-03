
local Wave = require 'model.wave'
local Unit = require 'model.unit'
local Vec = require 'common.vec'
local Cursor = require 'view.cursor'
local SpriteAtlas = require 'view.sprite_atlas'
local BattleField = require 'view.battlefield'
local Stats = require 'view.stats'
local State = require 'state'
local Chosestartmonstercoord = require 'state.chose_start_monster_coord'
local CheckKill = require 'state.check_kill'
local BuildWaves = require 'model.build_waves'
local COLLISION = require 'state.collision'

local PlayStageState = require 'common.class' (State)

function PlayStageState:_init(stack)
  self:super(stack)
  self.stage = nil
  self.cursor = nil
  self.atlas = nil
  self.battlefield = nil
  self.units = nil
  self.wave = nil
  self.stats = nil
  self.monsters = nil
end

function PlayStageState:enter(params)
  self.stage = params.stage
  self:_load_view()
  self:_load_units()
end

function PlayStageState:leave()
  self:view('bg'):remove('battlefield')
  self:view('fg'):remove('atlas')
  self:view('bg'):remove('cursor')
  self:view('hud'):remove('stats')
end

function PlayStageState:_load_view()
  self.battlefield = BattleField()
  self.atlas = SpriteAtlas()
  self.cursor = Cursor(self.battlefield)
  local _, right, top, _ = self.battlefield.bounds:get()
  self.stats = Stats(Vec(right + 16, top))
  self:view('bg'):add('battlefield', self.battlefield)
  self:view('fg'):add('atlas', self.atlas)
  self:view('bg'):add('cursor', self.cursor)
  self:view('hud'):add('stats', self.stats)
end

local check_position = function(x, y)
  for _, pos in ipairs(_G.landscape) do
    if pos[1] == x and pos[2] == y then
      return false
    end
  end
  return true
end

function PlayStageState:_load_Landscape(battlefield, landscape)
  local worldSize = {-6,6}  math.randomseed(os.time())-- mundo 6x6 não preciso checar colisão na criação dos monstros.
  for _, object in ipairs(landscape) do
      local unit = object['type']
      local length = object['num']
      local tab = {}
      for i=1, length do
        local x = math.random(worldSize[1],worldSize[2])
        local y = math.random(worldSize[1],worldSize[2])
        if check_position(x, y) then
          table.insert(tab,x)  table.insert(tab,y)
          table.insert(_G.landscape,tab)
          tab = {}
          local pos = battlefield:tile_to_screen(x, y)
          table.insert(_G.landscape,pos)
          self:_create_unit_at(unit, pos)
        end
      end
  end
end

function PlayStageState:_create_unit_at(specname, pos)
  local unit = Unit(specname)
  self.atlas:add(unit, pos, unit:get_appearance())
  return unit
end

function PlayStageState:_move_unit_at(monster, pos)
  local unit = monster
  self.atlas:add(unit, pos, unit:get_appearance())
  return unit
end

function PlayStageState:_load_units()
  local pos = self.battlefield:tile_to_screen(0, 0)--mudar para o centro
  self.units = {}
  -- Parametrizar a cidade desenhada
  self:_create_unit_at('capital', pos)
  local x = 9 local y = 2 local numheart = 4 local type = 'heart'
  for i=1, numheart do
    pos = self.battlefield:tile_to_screen(x, y)
    self:_create_unit_at(type, pos)
    table.insert(_G.heart, pos)
    x = x + 1
  end

  pos = self.battlefield:tile_to_screen(10, -5)
  self:_create_unit_at('archer', pos)

  local landscape = self.stage.landscape[1]
  self:_load_Landscape(self.battlefield, landscape)
  self.wave = Wave(self.stage.waves[1])
  self.wave:start()
  self.monsters = {}

end


function PlayStageState:on_mousepressed(_, _, button)
  local name
  print("on_mousepressed button=", button)
  if button ~= 1 then name = 'warrior'
  else name = 'archer' end
  -- Parametrizar o heroi a ser posto na tela
  local cursorPositionVector = Vec(self.cursor:get_position())
  local x = cursorPositionVector.x
  local y = cursorPositionVector.y
  local b = self.battlefield.bounds

  if (b.left <= x and x <= b.right) and (b.top <= y and y <= b.bottom) then
    self:_create_unit_at(name, cursorPositionVector)
  end
end

function sleep(s)
  local delay = 8000000
  --print(delay)
  while delay > 0 do
    delay = delay - s
  end
end

local myMonsters = {}
local stop = true
local coorX = 0
local coorY = 0

function PlayStageState:update(dt)

  local x = 0 local y = 0
  self.wave:update(dt)
  --local rand = love.math.random
  local pending = self.wave:poll()
  while pending > 0 do --calcular o caminho
  if stop then
    stop = false
      math.randomseed(os.time())
      local vel  = 0
      local cont = 1
      local waves = self.stage.waves
      local aux = BuildWaves:build_wave(waves)
      local type
      local num = 0
      local cont_monster = 0
      local tab = {}
      while cont <= #aux do --calcular o caminho/inserir numero correto de monstros
         tab = aux[cont]
         type = tab[1]
         num = tab[2]
         while cont_monster < num do
            x, y = Chosestartmonstercoord.origen_coord(x, y)
            local pos = self.battlefield:tile_to_screen(x, y)
            local monster = self:_create_unit_at(type, pos)
            vel = math.random(5, 15)
            table.insert(monster, {pos, vel, cont})
            self.monsters[monster] = true
            table.insert(myMonsters , monster)
            cont_monster = cont_monster + 1
          end
        cont_monster = 0
        cont = cont + 1
      end
  end
      pending = pending - 1
  end

  tab = {}
  local aux = {}
  local hit = 0
  local num = 10
  local heartCont = 1

  for _,monster in ipairs(myMonsters) do--realizar o movimento
      aux = monster[1]
      local pos = aux[1]
      local sprite_instance = self.atlas:get(monster)
      --verifico colisoes com os ostaculos
      if COLLISION:checkCollision(pos['x'], pos['y']) then
      if pos['x'] > 300 then
        pos['x'] = pos['x'] - 1
        coorX = -1
      else
        pos['x'] = pos['x'] + 1
        coorX = -1
      end
      if pos['y'] > 300 then
        pos['y'] = pos['y'] - 1
        coorY = -1
      else
        pos['y'] = pos['y'] + 1
        coorY = -1
      end
      sprite_instance.position:add(Vec(coorX, coorY) * aux[2] * dt)
      else
         --[[math.randomseed(os.time())
          local numX = math.random(100)
          local numY = math.random(100)
          if numX >= 50 then coorX = 1 else coorX = -1 end
          if numX < 50 then coorY = 1 else coorY = -1 end]]
          sprite_instance.position:add(Vec(0, 0)  * aux[2] * dt)
      end
      --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
      if (pos['x'] > 298 and pos['x'] < 301) and (pos['y'] > 298 and pos['y'] < 301) then
        hit = hit + 1
        if CheckKill:check_kill(hit) then
          if  _G.heart[heartCont] ~= nill then
            self:_create_unit_at('kill', _G.heart[heartCont])
          end
          if heartCont < #_G.heart then heartCont = heartCont + 1
          else
            local gameover = true
          end
          --sleep(dt*5)
        end
        if hit == 10 then
          while num > 0 do
            table.remove(myMonsters, 1)
            num = num - 1
          end
          hit = 11
        end
      end
  end
end

return PlayStageState
