
local Vec = require 'common.vec'
local Cursor = require 'common.class' ()

local CELL_SIZE = 32

function Cursor:_init()
  self.position = Vec()
end

function Cursor:set_position(position)
  self.position = (position / (Vec(1,1) * CELL_SIZE)):floor() * CELL_SIZE
  print(self.position)
end

function Cursor:draw()
  local g = love.graphics
  g.push()
  g.translate(self.position:get())
  g.setColor(.3, .3, .3)
  g.rectangle('fill', -CELL_SIZE/2, -CELL_SIZE/2, CELL_SIZE, CELL_SIZE)
  g.pop()
end

return Cursor

