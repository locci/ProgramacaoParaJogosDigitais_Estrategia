
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

function PlayStageState:_load_Landscape(battlefield, landscape)

  local unit = landscape[1]
  local length = landscape[2]
  math.randomseed(os.time())
  local tab = {}
  for i=1, length do
    local x = math.random(-7,7)
    local y = math.random(-7,7)
    table.insert(tab,x)
    table.insert(tab,y)
    table.insert(_G.landscape,tab)
    local pos = battlefield:tile_to_screen(x, y)
    self:_create_unit_at(unit, pos)
  end

end

function PlayStageState:_load_units()
  local pos = self.battlefield:tile_to_screen(0, 0)--mudar para o centro
  self.units = {}
  self:_create_unit_at('capital', pos)
  local landscape = self.stage.landscape[1]
  self:_load_Landscape(self.battlefield, landscape)
  self.wave = Wave(self.stage.waves[1])
  self.wave:start()
  self.monsters = {}
end

function PlayStageState:_create_unit_at(specname, pos)
  local unit = Unit(specname)
  self.atlas:add(unit, pos, unit:get_appearance())
  return unit
end

function PlayStageState:on_mousepressed(_, _, button)
  if button == 1 then
    self:_create_unit_at('warrior', Vec(self.cursor:get_position()))
  end
end

function PlayStageState:update(dt)
  self.wave:update(dt)
  local pending = self.wave:poll()
  local rand = love.math.random
  while pending > 0 do
    local x, y = rand(5, 7), -rand(5, 7)
    local pos = self.battlefield:tile_to_screen(x, y)
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

