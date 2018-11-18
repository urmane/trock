
local Talents = require("engine.interface.ActorTalents")

load("/data/general/npcs/base-lizard.lua")

newEntity{
    base = "BASE_LIZARD",
	define_as = "BASE_SNAKE",
	keywords = {snake=true},
	type = "snake", --subtype = "prisoner",
	display = "r", color=colors.UMBER,
	desc = [[A snake.]],
	image = "npcs/lizards/snake.png",
	faction = "animal",
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
}

newEntity{
	base = "BASE_SNAKE",
	name = "snake",
	subtype = "snake",
    image = "npcs/lizards/snake.png",
	color=colors.UMBER,
	level_range = {1,3}, exp_worth = 1, rarity = 1,
	--lite = 1,
	sight = 5,
	nightvision = 2,
    max_life = resolvers.rngavg(1,4),
    combat = { dam=1 },
}

