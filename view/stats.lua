
local Stats = require 'common.class' ()

function Stats:_init(position)
  self.position = position
  self.font = love.graphics.newFont('assets/fonts/VT323-Regular.ttf', 36)
  self.font:setFilter('nearest', 'nearest')
end

function Stats:draw()
  local g = love.graphics
  g.push()
  g.setFont(self.font)
  g.setColor(1, 1, 1)
  g.translate(self.position:get())
  g.print(("Gold %d"):format(1000))
  g.translate(0, self.font:getHeight())
  g.pop()
end

return Stats

