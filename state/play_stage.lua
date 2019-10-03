
local Wave = require 'model.wave'
local Unit = require 'model.unit'
local Vec = require 'common.vec'
local Cursor = require 'view.cursor'
local SpriteAtlas = require 'view.sprite_atlas'
local BattleField = require 'view.battlefield'
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
end

function PlayStageState:enter(params)
  self.stage = params.stage
  self:_load_view()
  self:_load_units()
end

function PlayStageState:_load_view()
  self.battlefield = BattleField()
  self.atlas = SpriteAtlas()
  self.cursor = Cursor(self.battlefield)
  self:view('bg'):add('battlefield', self.battlefield)
  self:view('fg'):add('atlas', self.atlas)
  self:view('bg'):add('cursor', self.cursor)
end

function PlayStageState:_load_units()
  local pos = self.battlefield:tile_to_screen(-6, 6)
  self.units = {}
  self:_create_unit_at('capital', pos)
  self.wave = Wave(self.stage.waves[1])
  self.wave:start()
end

function PlayStageState:_create_unit_at(specname, pos)
  local unit = Unit(specname)
  self.atlas:add(unit, pos, unit:get_appearance())
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
    self:_create_unit_at('green_slime', pos)
    pending = pending - 1
  end
end

return PlayStageState

