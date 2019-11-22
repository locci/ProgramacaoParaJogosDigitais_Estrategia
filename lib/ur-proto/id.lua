
local _last_id = 0

return function ()
  _last_id = _last_id + 1
  return _last_id
end

