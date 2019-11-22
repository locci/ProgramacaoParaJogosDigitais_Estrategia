
--- Stores the economy state.
--  Only a few classes in the unlimited rulebook have access to objects of the
--  @{Record} class. Any and all state is kept here, using a property-centric
--  object model (or "pure entity-component"). It loosely resembles a database
--  and the fact that the API looks vaguely similar to Ruby on Rails is no
--  coincidence.
--  @classmod Record

local Record = require 'common.class' ()

function Record:_init()
  self.definitions = {}
  self.properties = {}
end

--- Defines a new property specification.
--  A property is a table with predetermined fields, much like a struct in C.
--  You define a new property by providing default values for its fields.
--  @usage
--  record:new_property('spellcaster', { total_mana = 10 })
--  @tparam string name The name of the new property
--  @tparam table  fields A table with the default field values
function Record:new_property(name, fields)
  self.definitions[name] = fields
  self.properties[name] = {}
end

function Record:create(e, name)
  local property = {}
  for k, v in pairs(self.definitions[name]) do
    property[k] = v
  end
  self.properties[name][e] = property
  return property
end

--- Sets (creating, if necessary) the property fields of an entity.
--  It has two forms. In the first, a single field is set. In the second,
--  multiple fields are set at once.
--  @usage
--  -- first form
--  record:set(e, 'creature', 'power', 3)
--  -- second form
--  record:set(e, 'creature', { power = 3, toughness = 4 })
--  @tparam Entity e The entity being assigned the property
--  @tparam string name The name of the property
--  @param field The name of the field being set, or a table setting multiple
--  fields
--  @param value If `field` is a field name, this must be the field value
function Record:set(e, name, field, value)
  assert(self.definitions[name], "setting undefined property " .. name)
  local property = self.properties[name][e] or self:create(e, name)
  if type(field) == 'string' then
    property[field] = value
  elseif type(field) == 'table' then
    for k, v in pairs(field) do
      if self.definitions[name][k] ~= nil then
        property[k] = v
      end
    end
  end
end

--- Tells whether an @{Entity} has a certain property assigned to it.
--  @usage
--  if record:is(e, 'creature') then
--    print("It's a creature!")
--  end
--  @tparam Entity e The tested entity
--  @tparam string name The property name being checked
--  @treturn bool Whether the entity has the specified property
function Record:is(e, name)
  return assert(self.properties[name])[e] ~= nil
end

--- Gets a property field.
--  @usage
--  local power = record:get(e, 'creature', 'power')
--  @tparam Entity e The entity being whose property is being read
--  @tparam string name The name of the property
--  @tparam string field The name of the property's field
--  @return The value of the entity's property field
function Record:get(e, name, field)
  if self:is(e, name) then
    return self.properties[name][e][field]
  end
end

--- Lists all entities with the given property.
--  The result is NOT sorted.
--  @usage
--  for _, e in ipairs(record:all('creature')) do
--    e:check_something()
--  end
--  -- If you only want to count, the returned table has a 'n' field for that
--  if record:all('player').n == 1 then
--    print("Aaaaand we have a winner!")
--  end
--  @tparam string name Name of the property
--  @treturn table A sequence containing all entities with the given property
function Record:all(name)
  local result = {}
  local n = 0
  for e, _ in pairs(self.properties[name]) do
    n = n + 1
    result[n] = e
  end
  result.n = n
  return result
end

--- Lists all entities that match the fields for a single property
--  Fields not specified in the property definition are ignored. The result is
--  NOT sorted.
--  @usage
--  for _, e in ipairs(record:where('creature', { toughness = 0 })) do
--    e:destroy()
--  end
--  -- If you only want to count, the returned table has a 'n' field for that
--  if record:where('player', { life = 0 }).n > 0 then
--    print("Dead players detected!")
--  end
--  @tparam string name A property name
--  @tparam table match A table with the values expected for the property fields
--  @treturn table A sequence containing entities whose `name`-property have
--  field values matching those of the `match` parameter
function Record:where(name, match)
  local result = { n = 0 }
  for e, property in pairs(self.properties[name]) do
    local ok = true
    for k, v in pairs(match) do
      if property[k] ~= v then
        ok = false
        break
      end
    end
    if ok then
      result.n = result.n + 1
      result[result.n] = e
    end
  end
  return result
end

--- Remove a property from the @{Entity}.
--  @usage
--  record:clear(e, 'flying')
--  assert(not record:is(e, 'flying')
--  @tparam Entity e The entity losing a property
--  @tparam string name The name of the removed property
function Record:clear(e, name)
  assert(self.definitions[name], "clearing undefined property " .. name)
  self.properties[name][e] = nil
end

--- Remove all properties from the @{Entity}.
--  This is normally done when you will no longer use an entity. Do not
--  recycle entities.
--  @usage
--  record:clear_all(e)
--  assert(not record:is(e, 'flying')
--  assert(not record:is(e, 'creature')
--  -- etc.
--  @tparam Entity e The entity losing all its properties
function Record:clear_all(e)
  for _, property in pairs(self.properties) do
    property[e] = nil
  end
end

return Record

