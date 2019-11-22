
project = "UR Proto"

title = "Unlimited Rulebook Prototype's reference"

description = "Reference implementation of the Unlimited Rulebook architecture."

full_description = [[
This Lua module is intended for use in [LÖVE](https://love2d.org/) projects. In
particular, it was designed to fit perfectly into the projects from MAC0346
"Digital Games Programming" course at University of São Paulo. They can be found
[here](https://gitlab.com/Kazuo256/progjogos2019-projeto-rpg) and
[here](https://gitlab.com/Kazuo256/progjogos2019-projeto-tower-defense).

For installation and usage instructions, refer to the
[manual](topics/Manual.md.html).

[Here is the example using Magic: the Gathering
combat](https://gitlab.com/unlimited-rulebook/prototype-example)
]]

file = {
	"init.lua", "entity.lua", "record.lua", "ruleset.lua"
}
dir = "doc/html"
pretty = "lxsh"
style = "doc"
template = "doc"
merge = true
topics = { "doc/Manual.md", "doc/Architecture.md" }
manual_url = "http://www.lua.org/manual/5.1/manual.html"
format = "discount"

