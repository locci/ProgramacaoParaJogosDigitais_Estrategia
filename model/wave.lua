
local Wave = require 'common.class' ()

function Wave:_init(spawns)
  self.spawns = spawns
  self.delay = 3
  self.left = nil
  self.pending = 0
end

function Wave:start()
  self.left = self.delay
end

function Wave:update(dt)
  self.left = self.left - dt
  if self.left <= 0 then
    self.left = self.left + self.delay
    self.pending = self.pending + 1
  end
end

function Wave:poll()
  local pending = self.pending
  self.pending = 0
  return pending
end

return Wave

