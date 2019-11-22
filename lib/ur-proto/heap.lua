
local Heap = require 'common.class' ()

local function _maintain_up(array, i, cmp)
  local parent = math.floor(i/2)

  if parent > 0 and cmp(array[i], array[parent]) then
    local swap = array[i]
    array[i] = array[parent]
    array[parent] = swap
    return _maintain_up(array, parent, cmp)
  end
end

local function _maintain_down(array, i, limit, cmp)
  local left = i*2
  local right = left+1
  local higher = i

  if left <= limit and cmp(array[left], array[i]) then
    higher = left
  end

  if right <= limit and cmp(array[right], array[higher]) then
    higher = right
  end

  if higher ~= i then
    local swap = array[i]
    array[i] = array[higher]
    array[higher] = swap
    return _maintain_down(array, higher, limit, cmp)
  end
end

function Heap:_init(cmp)
  self.items  = {}
  self.size   = 0
  self.cmp    = cmp or function (a, b) return a > b end
end

function Heap:clear()
  for i = self.size, 1, -1 do
    self.items[i] = nil
  end
  self.size = 0
end

function Heap:pop()
  local item = self.items[1]
  self.items[1] = self.items[self.size]
  self.items[self.size] = nil
  self.size = self.size - 1
  _maintain_down(self.items, 1, self.size, self.cmp)
  return item
end

function Heap:push(e)
  self.size = self.size + 1
  self.items[self.size] = e
  _maintain_up(self.items, self.size, self.cmp)
end

function Heap:is_empty()
  return self.size <= 0
end

return Heap

