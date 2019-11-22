
local RuleSet = require 'ur-proto.ruleset'

local RuleLoader = require 'common.class' ()

function RuleLoader:_init()
  self.folders = { 'ur-proto.rules' }
end

function RuleLoader:add_module(path)
  table.insert(self.folders, path)
end

function RuleLoader:load_ruleset(name, record, solver)
  local loader = self:_find_ruleset_loader(name)
  assert(loader, "ruleset '" .. name .. "' not found")
  local ruleset = RuleSet(name, record, solver)
  loader(ruleset)
end

function RuleLoader:_find_ruleset_loader(name)
  for _, folder in ipairs(self.folders) do
    local ok, loader = pcall(require, folder .. '.' .. name)
    if ok then
      return loader
    end
  end
end

return RuleLoader

