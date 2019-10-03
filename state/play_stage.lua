
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
end

function PlayStageState:enter(params)
  self.battlefield = BattleField()
  self:view('bg'):add('battlefield', self.battlefield)
  self.atlas = SpriteAtlas()
  self.stage = params.stage
  local pos = self.battlefield:tile_to_screen(-6, 6)
  self.atlas:add('capital', pos, 'citadel')
  self:view('fg'):add('atlas', self.atlas)
  self.cursor = Cursor()
  self:view('bg'):add('cursor', self.cursor)
end

function PlayStageState:update(_)
  local mouse_pos = Vec(love.mouse.getPosition())
  local rounded = self.battlefield:round_to_tile(mouse_pos)
  self.cursor:set_position(rounded:get())
end

function PlayStageState:on_mousepressed(_, _, button)
  if button == 1 then
    self.atlas:add({}, Vec(self.cursor:get_position()), 'knight')
  end
end

return PlayStageState

