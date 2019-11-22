
--- Loads a set of rules.
--
--  When @{RuleEngine} is instantiated, you pass it a lsit of ruleset paths to
--  load. Each of these Lua scripts should return a function that operates on
--  a `RuleSet` object (like in the *Visitor* pattern). This function uses the
--  ruleset object to mainly define rules and has access to the @{Record} object
--  being used to store the state of the @{RuleEngine}.
--
--  To define a rule, you use the Lua syntax for defining methods to the
--  `define` field of the ruleset object. The name you use is the name of the
--  rule you are defining. The method takes the parameters the rule itself
--  should take, but it does not implement the behavior of the rule. Instead,
--  you should define two function in the `self` object of that method: `when`
--  and `apply`.
--
--  The `when` function should return true only if the rule is applicable given
--  its parameters and any other state in the @{Record}. The `apply` function is
--  the one responsible for implementing the trait (read-only behavior) or
--  effect (state-changing behavior) associated with the defined rule.
--
--  A rule definition method may also set `self.compose = true` to indicate that
--  the rule should compose its implementation with lower-precedence rules. In
--  this case, a special parameter `super` is passed to the `apply` function.
--  It is the `apply` function of the rule with immediately inferior precedence
--  to the current rule (or a dummy function, if there is no such rule).
--
--  @usage
--  -- A hypothetical "character.lua" rule set
--  return function (ruleset)
--
--    -- "Alias" variable
--    local r = ruleset.record
--
--    r:new_property('character', { hp = 1 })
--
--    -- Defining a trait rule
--    function ruleset.define:get_hp(e)
--      function self.when()
--        return r:is(e, 'character')
--      end
--      function self.apply()
--        return r:get(e, 'character', 'hp')
--      end
--    end
--
--    -- Defining an effect rule
--    function ruleset.define:take_damage(e, amount)
--      function self.when()
--        return r:is(e, 'character')
--      end
--      function self.apply()
--        local hp = e.hp -- call the previous rule
--        hp = math.max(0, hp - amount)
--        r:set(e, 'character', 'hp', hp) -- state-changing effect
--      end
--    end
--
--    -- Defining a composed trait rule
--    function ruleset.define:get_description(e)
--      self.compose = true
--      function self.when()
--        return r:is(e, 'character')
--      end
--      function self.apply(super)
--        local previous = super() or ""
--        return previous .. ("\nA character with %d hit points"):format(e.hp)
--      end
--    end
--
--  end
--
--  @classmod RuleSet

local Entity = require 'ur-proto.entity'
local RuleSet = require 'common.class' ()

local _meta = {}

function RuleSet:_init(setname, record, solver)
  self.setname = setname
  self.record = record
  self.factory = function () return Entity(record, solver) end
  self.define = setmetatable({ set = self }, _meta)
  self.last_rule = nil
end

--- Creates a new, property-less entity.
--  @treturn Entity A new entity
function RuleSet:new_entity()
  return self.factory()
end

function RuleSet:_define_rule(name, definition)
  local e = self.factory()
  self.record:set(e, 'rule', { name = name,
                               definition = definition })
  self.last_rule = e
end

--- Returns the last rule defined in this ruleset
--  Rules are entities like everything else, so @{Record} operations work on
--  them as usual.
--  @treturn Entity The entity of the last defined rule
function RuleSet:get_last_rule()
  return self.last_rule
end

function _meta:__newindex(key, value)
  self.set:_define_rule(key, value)
end

return RuleSet

