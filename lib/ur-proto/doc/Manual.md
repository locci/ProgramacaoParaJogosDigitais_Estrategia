
# Manual

If you have any questions, don't hesitate to ask on the
[PACA boards](https://paca.ime.usp.br) or [open an
issue](https://gitlab.com/unlimited-rulebook/ur-proto/issues).

## Installation

Download, clone or submodule [the source
code](https://gitlab.com/unlimited-rulebook/ur-proto) in a `lib/` folder in the
root of your project. It should look more or less like this:

```
project/
  assets/
  common/
  database/
  lib/
    ur-proto/ <-- place it here
  model/
  state/
  view/
  conf.lua
  main.lua
  stack.lua
``` 

After this, add the following lines to your `love.load()`:

```lua
local path = love.filesystem.getRequirePath()
love.filesystem.setRequirePath("lib/?.lua;lib/?/init.lua;" .. path)
```

## Usage

After following the steps above, you can import the unlimited rulebook's
@{RuleEngine} class with:

```lua
local RuleEngine = require 'ur-proto'
```

Whenever the game starts a new economy simulation scenario (a new quest, a new
stage, etc.), create an instance of the @{RuleEngine} class feeding it the
appropriate rule set paths (see its constructor reference for details).

Every method call on a @{RuleEngine} object is treated as a rule invocation.
Ideally, some of the rules you make will create economy entities in the
simulation and return them (e.g. a `engine:create_character()` rule). Method
calls on entities are also forwarded as rule invocations, except they implicitly
pass the entity as the first parameter to the rule:

```lua
local engine = RuleEngine(--[[ ruleset paths ]])

-- Invokes rule "create_character" with argument "bob"
local some_character = engine:create_character("bob")

-- Invokes rule "gain_exp" with arguments (some_character, "bob")
some_character:gain_exp(15)
```

See the @{RuleSet} reference for details on how to define rules.

