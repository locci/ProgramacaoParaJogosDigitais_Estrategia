
local Wave = require 'model.wave'
local Unit = require 'model.unit'
local Vec = require 'common.vec'
local Cursor = require 'view.cursor'
local SpriteAtlas = require 'view.sprite_atlas'
local BattleField = require 'view.battlefield'
local Stats = require 'view.stats'
local State = require 'state'
local Chosestartmonstercoord = require 'state.chose_start_monster_coord'
local CheckKill = require 'state.check_kill'
local BuildWaves = require 'model.build_waves'
local CIRCLEFIELD = require 'battle.circlefield'
local Indexer = require 'database.indexer'
local Sound = require 'common.sound'
local Hit = require 'battle.hit'

local castlePos = {0,0}
local landscp = {}
table.insert(landscp, castlePos)
local heart = {}
local nameHero = 'warrior'

local PlayStageState = require 'common.class' (State)

function PlayStageState:_init(stack)
  self:super(stack)
  self.stage = nil
  self.cursor = nil
  self.atlas = nil
  self.battlefield = nil
  self.units = nil
  self.wave = nil
  self.gold = nil
  self.lives = nil
  self.monsters = nil
end

function PlayStageState:enter(params)
  self.stage = params.stage
  self:_load_view()
  self:_load_units()
end

function PlayStageState:leave()
  self:view('bg'):remove('battlefield')
  self:view('fg'):remove('atlas')
  self:view('bg'):remove('cursor')
  self:view('hud'):remove('gold')
  self:view('hud'):remove('lives')
end

function PlayStageState:_load_view()
  self.battlefield = BattleField()
  self.atlas = SpriteAtlas()
  self.cursor = Cursor(self.battlefield)
  local _, right, top, _ = self.battlefield.bounds:get()
  local gold = self.stage.gold
  self.gold = Stats(Vec(right + 16, top), "Gold ", gold)
  self.lives = Stats(Vec(610, 346), "x", 10)
  self:view('bg'):add('battlefield', self.battlefield)
  self:view('fg'):add('atlas', self.atlas)
  self:view('bg'):add('cursor', self.cursor)
  self:view('hud'):add('gold', self.gold)
  self:view('hud'):add('lives', self.lives)
  Sound:play('theme', 0.4)
end

local check_position = function(x, y)
  for _, pos in ipairs(landscp) do
    if pos[1] == x and pos[2] == y then
      return false
    end
  end
  return true
end

local selected = Unit("archer")
local unitsInMenu = {}
local unitsInField = {}

function PlayStageState:_load_Landscape(battlefield, landscape)
  local worldSize = {lower = -6, upper = 6}  math.randomseed(os.time())
  -- mundo 6x6 não preciso checar colisão na criação dos monstros.
  for _, object in ipairs(landscape) do
      local unit = object['type']
      local length = object['num']
      local tab = {}
      for i=1, length do
        local x = math.random(worldSize.lower,worldSize.upper)
        local y = math.random(worldSize.lower,worldSize.upper)
        local aux = self.battlefield:tile_to_screen(Vec(x,y):get())

        local unit = self:_create_unit_at(object.type, aux, true)

        if check_position(x, y) then
          table.insert(tab,x)
          table.insert(tab,y)
          table.insert(landscp,tab)
          tab = {}
          local pos = battlefield:tile_to_screen(x, y)
          table.insert(landscp,pos)
          self:_create_unit_at(object.type, pos, true)
        end
      end
  end
end

function PlayStageState:_create_unit_at(specname, pos, putIn, drawCircle)
  local unit = Unit(specname)
  if putIn then
    local index = Indexer.index(pos)
    unit:setPos(pos)
    unitsInField[index] = unit
  end
  unit:setDrawCircle(drawCircle)
  self.atlas:add(unit, pos, unit:get_appearance())
  return unit
end

function PlayStageState:_move_unit_at(monster, pos)
  local unit = monster
  self.atlas:add(unit, pos, unit:get_appearance())
  return unit
end

function PlayStageState:_load_units()
  local pos = self.battlefield:tile_to_screen(0, 0)--mudar para o centro
  self.units = {}
  -- Parametrizar a cidade desenhada
  pos = self.battlefield:tile_to_screen(0, 0)
  self:_create_unit_at('capital', pos, true)
  for i=9,12 do
    pos = self.battlefield:tile_to_screen(i, 2)
    self:_create_unit_at('heart', pos)
    local sound = true
    table.insert(heart, sound)
  end

  -- Ainda da pra melhorar (usar os limites do quadro de brodas brancas como referencia para a posicao)
  herosMenu = require 'database.herosMenu'
  for _, hero in ipairs(herosMenu) do
    pos = self.battlefield:tile_to_screen(hero.pos:get())
    -- criar objeto guerreiro
    local index = Indexer.index(pos)
    unitsInMenu[index] = hero.appearance
    self:_create_unit_at(hero.appearance, pos, _, false)
  end

  local landscape = self.stage.landscape[1]
  self:_load_Landscape(self.battlefield, landscape)
  self.wave = Wave(self.stage.waves[1])
  self.wave:start()
  self.monsters = {}
end

function PlayStageState:on_mousepressed(_, _, button)

  -- Parametrizar o heroi a ser posto na tela
  local cursor = Vec(self.cursor:get_position())
  local x, y = cursor:get()
  local b = self.battlefield.bounds
  local l, r, t, bot = b.left, b.right, b.top, b.bottom

  -- cursor esta dentro do campo de batalha
  if (l <= x - 32 and x <= r - 32) and (t <= y - 32 and y <= bot - 32) then
    local index = Indexer.index(cursor)
    local gold = self.gold.quantity
    local unit = unitsInField[index]

    -- LEVEL UP
    local lvlCost = selected:getLevelUpCost()
    if unit and not unit:isMaxLevel() and gold > lvlCost then
      unit:levelUp()
      self.gold.quantity = self.gold.quantity - lvlCost
    end

    if unit == nil and gold > selected:get_cost() then
      self:_create_unit_at(selected:get_appearance(), cursor, true, true)
      self.gold.quantity = self.gold.quantity - selected:get_cost()
    end
  end

  local menu = self.battlefield.menu_bounds
  -- cursor esta dentro do menu de selecao de personagens
  if (menu.left <= x and x <= menu.right) and (menu.top <= y and y <= menu.bottom) then
    local pos = self.battlefield:pos_to_tile(cursor)
    local index = Indexer.index(pos)
    -- pegar aqui o personagem selecionado
    if unitsInMenu[index] ~= nil then
      print(unitsInMenu[index])
      selected = Unit(unitsInMenu[index])
      selected:setPos(pos)
    end
  end
end

function sleep(s)
  local delay = 8000000

  while delay > 0 do
    delay = delay - s
  end
end

local myMonsters = {}
local stop = true
local coorX = 0
local coorY = 0


local function go(posi, destinyX, destinyY)
  local X
  local Y
  if posi['x'] > destinyX then
    posi['x'] = posi['x'] - 1
    X = -1
  else
    posi['x'] = posi['x'] + 1
    X = 1
  end
  if posi['y'] > destinyY then
     posi['y'] = posi['y'] - 1
     Y = -1
  else
     posi['y'] = posi['y'] + 1
     Y = 1
  end
  return X, Y, posi['x'], posi['y']
end

local playHit = 0

function PlayStageState:update(dt)
  local x = 0 local y = 0
  self.wave:update(dt)

  Hit.getStats(unitsInField, self.atlas)
  Hit:updateBattle(dt)

  local pending = self.wave:poll()
  while pending > 0 do --calcular o caminho
    if stop then
      stop = false
        math.randomseed(os.time())
        local vel  = 0
        local cont = 1
        local waves = self.stage.waves
        local aux = BuildWaves:build_wave(waves)
        local type
        local num = 0
        local cont_monster = 0
        local tab = {}
        while cont <= #aux do --calcular o caminho/inserir numero correto de monstros
           tab = aux[cont]
           type = tab[1]
           num = tab[2]
           while cont_monster < num do
              x, y = Chosestartmonstercoord.origen_coord(x, y)
              local pos = self.battlefield:tile_to_screen(x, y)

              local monster = self:_create_unit_at(type, pos, true, true)
              vel = math.random(4, 4.1)
              table.insert(monster, {pos, vel, cont_monster, true, true})--5 hitdound
              table.insert(myMonsters , monster)
              cont_monster = cont_monster + 1
            end
          cont_monster = 0
          cont = cont + 1
        end
    end
    pending = pending - 1
  end

  tab = {}
  local aux = {}
  local hit = 0
  local num = 10
  local contDeath = 9
  local heartCont = 1
  local cont = 0

  for _, monster in ipairs(myMonsters) do--realizar o movimento
      aux = monster[1]
      local pos = aux[1]
      local sprite_instance = self.atlas:get(monster)
    --verifico colisoes com os ostaculos
      if CIRCLEFIELD:checkCollision(pos['x'], pos['y'], landscp)  then
          coorX, coorY, pos['x'], pos['y'] = go(pos, 300, 300)
          sprite_instance.position:add(Vec(coorX, coorY) * aux[2] * dt)
      else
          coorX, coorY,  pos['x'], pos['y'] = go(pos, pos['x'] + 1, pos['y'] + 1)
          sprite_instance.position:add(Vec(coorX,coorY) * aux[2] * dt)
      end
      if (pos['x'] > 298 and pos['x'] < 301) and (pos['y'] > 298 and pos['y'] < 301) then
          hit = hit + 1

          monster:changeHp(monster:get_hp())

          if aux[5] == true then
               Sound:play('hitcapital', 0.4)
               aux[5] = false
          end
          if hit % 3  == 0 then
              pos = self.battlefield:tile_to_screen(contDeath, 2)
              self:_create_unit_at('kill', pos)
              contDeath = contDeath + 1
          end
          if heartCont < #heart then
               sprite_instance.position:add(Vec(0, 0)  * 0 * dt)
               heartCont = heartCont + 1
          else
             stop = false
             local gameover = true
          end
    end
  end

end

return PlayStageState
