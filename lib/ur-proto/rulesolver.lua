
--- Applies rules to the economy state, solving conflicts.
--  @classmod RuleSolver

local Heap = require 'ur-proto.heap'

local RuleSolver = require 'common.class' ()

local NOOP = function () end

function RuleSolver:_init(record) -- luacheck: no self
  record:new_property('rule', { name = "unknown",
                                definition = function () end })
end

function RuleSolver:rule(rulename, record)
  if record:where('rule', { name = rulename }).n > 0 then
    return function (...)
      self:apply(rulename, record, ...)
    end
  end
end

function RuleSolver:apply(rulename, record, ...)
  local possible_cases = record:where('rule', { name = rulename })
  if possible_cases.n == 0 then
    return print("no such rule: " .. rulename)
  end
  local n = 0
  local matched_cases = {}
  for _, case in ipairs(possible_cases) do
    local match = {}
    local definition = record:get(case, 'rule', 'definition')
    definition(match, ...)
    match.case = case
    assert(match.when and match.apply, "malformed rule case")
    if match.when() then
      n = n + 1
      matched_cases[n] = match
    end
  end
  if n > 0 then
    if n == 1 then
      return matched_cases[1].apply(NOOP)
    else
      return self:_solve_conflict(record, matched_cases)
    end
  else
    print("no rule case applies: " .. rulename)
  end
end

function RuleSolver:_solve_conflict(record, cases)
  local cmp = function (a, b)
    return self:apply('precedes', record, b.case, a.case)
  end
  local heap = Heap(cmp)
  for _, match in ipairs(cases) do
    heap:push(match)
  end
  local apply
  while not heap:is_empty() do
    local match = heap:pop()
    if match.compose then
      local super = apply or NOOP
      apply = function () return match.apply(super) end
    else
      apply = match.apply
    end
  end
  return apply()
end

return RuleSolver

