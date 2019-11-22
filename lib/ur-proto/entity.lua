
--- An entity managed by the rule engine.
--
--  Any method you try to call on objects of this class will result in an
--  attempt to invoke a rule of the same name, passing the entity itself as the
--  first argument.
--
--  Any field you try to read or write to is coerced into a rule invocation
--  with names `get_<fieldname>` and `set_<fieldname>`, respectively.
--
--  You do not create entity objects directly. In code outside the rules, only
--  rule invocations may provide new entity objects. In rule code, you can
--  create new entities with @{RuleSet:new_entity}.
--
--  The only real field an entity object has is `id`, which contains a unique
--  number for internal purposes like debugging and rules precedence
--  calculation.
--
--  @usage
--  -- Invokes hypothetical rule "create_character", which retuns a new entity
--  local e = engine:create_character()
--
--  -- Invokes rule `cast_spell` with arguments (e, "fireball")
--  e:cast_spell("fireball")
--
--  -- Prints the result of invoking rule "get_hp" with argument (e)
--  print(e.hp)
--
--  -- Invokes tule `set_gild` with arguments (e, 0)
--  e.gild = 0
--
--  @classmod Entity

local ID = require 'ur-proto.id'

local Entity = require 'common.class' ()

function Entity:_init(record, solver)
  rawset(self, 'id', ID())
  rawset(self, 'record', record)
  rawset(self, 'solver', solver)
end

function Entity:__index(key)
  local rulename = key
  if self.record:where('rule', { name = key }).n > 0 then
    return function (_, ...)
      return self.solver:apply(rulename, self.record, self, ...)
    end
  else
    return self.solver:apply('get_' .. rulename, self.record, self)
  end
end

function Entity:__newindex(key, value)
  return self.solver:apply('set_' .. key, self.record, self, value)
end

function Entity:__tostring()
  return ("entity: %d"):format(self.id)
end

return Entity

