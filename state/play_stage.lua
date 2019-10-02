
local Vec = require 'common.vec'
local Cursor = require 'view.cursor'
local SpriteAtlas = require 'view.sprite_atlas'
local State = require 'state'

local PlayStageState = require 'common.class' (State)

function PlayStageState:_init(stack)
  self:super(stack)
  self.stage = nil
  self.cursor = nil
end

function PlayStageState:enter(params)
  local center = Vec(love.graphics.getDimensions()) / 2
  local atlas = SpriteAtlas()
  self.stage = params.stage
  atlas:add('capital', center, 'citadel')
  self:view('fg'):add('atlas', atlas)
  self.cursor = Cursor()
  self.cursor:set_position(center)
  self:view('bg'):add('cursor', self.cursor)
end

return PlayStageState

