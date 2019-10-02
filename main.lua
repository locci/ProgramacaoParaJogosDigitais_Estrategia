
local Stack = require 'stack'
local View  = require 'view'

local _game
local _stack

function love.load()
  _game = {
    bg_view = View(),
    fg_view = View(),
    hud_view = View()
  }
  _stack = Stack(_game)
  _stack:push('choose_stage')
end

function love.update(dt)
  _stack:update(dt)
  _game.bg_view:update(dt)
  _game.fg_view:update(dt)
  _game.hud_view:update(dt)
end

function love.draw()
  _game.bg_view:draw()
  _game.fg_view:draw()
  _game.hud_view:draw()
end

for eventname, _ in pairs(love.handlers) do
  love[eventname] = function (...)
    _stack:forward(eventname, ...)
  end
end

