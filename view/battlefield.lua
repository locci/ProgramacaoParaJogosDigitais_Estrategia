
local Box = require 'common.box'
local Vec = require 'common.vec'
local BattleField = require 'common.class' ()

function BattleField:_init()
  local h = love.graphics.getHeight()
  local center = Vec(1, 1) * h / 2
  local size = Vec(1, 1) * 32 * 8
  self.bounds = Box.from_vec(center, size)
end

function BattleField:center()
  local b = self.bounds
  return (Vec(b.left, b.top) + Vec(b.right, b.bottom)) / 2
end

function BattleField:round_to_tile(pos)
  local center = self:center()
  local dist = pos - center
  local tile = ((dist + Vec(16, 16)) / 32):floor()
  tile:clamp(7, 7)
  return center + tile * 32
end

function BattleField:tile_to_screen(x, y)
  local center = self:center()
  return center + Vec(x, y):floor() * 32
end

function BattleField:draw()
  local g = love.graphics
  g.setColor(1, 1, 1)
  g.setLineWidth(4)
  g.rectangle('line', self.bounds:get_rectangle())
end

return BattleField

