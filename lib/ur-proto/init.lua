
--- The economy mechanics rule simulation engine.
--
--  Any method you try to call on objects of this class will result in an
--  attempt to invoke a rule of the same name.
--
--  @usage
--  local RuleEngine = require 'ur-proto'
--
--  -- Use Lua's module path notation!
--  local MODULE_PATHS = { 'my_game.rules', 'some_extension.rules' }
--  -- Remember: the order is important!
--  local RULESETS = { 'character', 'item', 'inventory' }
--
--  local engine = RuleEngine(MODULE_PATHS, RULESETS)
--
--  -- Tries to invoke rule "give_item" with the given parameters.
--  engine:give_item(some_character, some_item)
--
--  @classmod RuleEngine

local Record        = require 'ur-proto.record'
local RuleLoader    = require 'ur-proto.ruleloader'
local RuleSolver    = require 'ur-proto.rulesolver'

local RuleEngine = require 'common.class' ()

local CORE_RULESETS = {
  'common', 'name', 'report'
}

local _load_rulesets

--- Class constructor.
--
--  Note that rulesets are loaded following the given order, and their scripts
--  are sought following the paths also in the given order. Rule order is
--  important for conflict resolution, so pay attention!
--
--  @tparam table paths list of paths where ruleset scripts will be loaded from
--  @tparam table rulesets list of ruleset names to load, in order
function RuleEngine:_init(paths, rulesets)
  self.record = Record()
  self.rule_solver = RuleSolver(self.record)
  self.rule_loader = RuleLoader()
	for _, path in ipairs(paths) do
		self.rule_loader:add_module(path)
	end
	_load_rulesets(self, CORE_RULESETS)
	_load_rulesets(self, rulesets)
end

--- Forwards method calls as rule invocations.
--  Field access works normally.
--  @tparam string key the rule name
--  @treturn function a wrapper that invokes the corresponding rule
function RuleEngine:__index(key)
  return rawget(self, key) or function (_, ...)
    return self.rule_solver:apply(key, self.record, ...)
  end
end

function _load_rulesets(engine, list)
  for _, set in ipairs(list) do
    engine.rule_loader:load_ruleset(set, engine.record, engine.rule_solver)
  end
end

return RuleEngine

