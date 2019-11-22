
local Wave = require 'model.wave'
local Unit = require 'model.unit'
local Vec = require 'common.vec'
local Cursor = require 'view.cursor'
local SpriteAtlas = require 'view.sprite_atlas'
local BattleField = require 'view.battlefield'
local Stats = require 'view.stats'
local State = require 'state'

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
  local worldSize = {-7,7}  math.randomseed(os.time())
  for _, object in ipairs(landscape) do
      local unit = object['type']
      local length = object['num']
      local tab = {}
      for i=1, length do
        local x = math.random(worldSize[1],worldSize[2])
        local y = math.random(worldSize[1],worldSize[2])
        if check_position(x, y) then
          table.insert(tab,x)
          table.insert(tab,y)
          table.insert(_G.landscape,tab)
          tab = {}
          local pos = battlefield:tile_to_screen(x, y)
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

function PlayStageState:_load_units()
  local pos = self.battlefield:tile_to_screen(0, 0)--mudar para o centro
  self.units = {}
  -- Parametrizar a cidade desenhada
  self:_create_unit_at('capital', pos)
  local x = 9 local y = 2 local numheart = 4 local type = 'heart'
  for i=1, numheart do
    pos = self.battlefield:tile_to_screen(x, y)
    self:_create_unit_at(type, pos)
    x = x + 1
  end
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
  self:_create_unit_at(name, Vec(self.cursor:get_position()))
end

function PlayStageState:update(dt)
  self.wave:update(dt)
  local pending = self.wave:poll()
  local rand = love.math.random
  while pending > 0 do
    local x, y = rand(5, 7), -rand(5, 7)
    local pos = self.battlefield:tile_to_screen(x, y)
    -- Parametrizar o monstro a ser posto na tela
    local monster = self:_create_unit_at('green_slime', pos)
    self.monsters[monster] = true
    pending = pending - 1
  end
  for monster in pairs(self.monsters) do
    local sprite_instance = self.atlas:get(monster)
    sprite_instance.position:add(Vec(-1, 1) * 10 * dt)
  end
end

return PlayStageState
