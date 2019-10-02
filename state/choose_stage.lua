
local PALETTE_DB = require 'database.palette'
local State = require 'state'
local ListMenu = require 'view.list_menu'
local Vec = require 'common.vec'

local ChooseStageState = require 'common.class' (State)

local LMARGIN = 32

function ChooseStageState:_init(stack)
  self:super(stack)
  local options = self:_load_stages()
  local h = love.graphics.getHeight()
  self.menu = ListMenu(options)
  self.menu.position = Vec(LMARGIN, h / 2)
end

function ChooseStageState:_load_stages()
  local options = {}
  local stage_names = love.filesystem.getDirectoryItems('database/stages')
  self.stages = {}
  for i, name in ipairs(stage_names) do
    name = name:sub(1, -5)
    local stage = require('database.stages.' .. name)
    options[i] = stage.title
    self.stages[i] = stage
  end
  return options
end

function ChooseStageState:enter()
  love.graphics.setBackgroundColor(PALETTE_DB.black)
  self:view('hud'):add('stage_menu', self.menu)
end

function ChooseStageState:suspend()
  self:view('hud'):remove('stage_menu')
end

function ChooseStageState:resume()
  self:view('hud'):add('stage_menu', self.menu)
end

function ChooseStageState:leave()
  self:view('hud'):remove(self.menu)
end

function ChooseStageState:on_keypressed(key)
  if key == 'down' then
    self.menu:next()
  elseif key == 'up' then
    self.menu:previous()
  elseif key == 'return' then
    local option = self.menu:current_option()
    local params = { stage = self.stages[option] }
    return self:push('play_stage', params)
  elseif key == 'escape' then
    return self:pop()
  end
end

return ChooseStageState


