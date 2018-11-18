
local Talents = require("engine.interface.ActorTalents")

load("/data/general/npcs/base-animal.lua")

newEntity{
    base = "BASE_ANIMAL",
	define_as = "BASE_RODENT",
	keywords = {rodent=true},
	type = "rodent", --subtype = "prisoner",
	display = "r", color=colors.UMBER,
	desc = [[A rodent.]],
	image = "npcs/rodents/rodent.png",
	faction = "animal",
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
}

newEntity{
	base = "BASE_RODENT",
	name = "giant rat",
	subtype = "giantrat",
    image = "npcs/rodents/giantrat.png",
	color=colors.UMBER,
	level_range = {1,3}, exp_worth = 1, rarity = 1,
	--lite = 1,
	sight = 3,
	nightvision = 1,
    max_life = resolvers.rngavg(1,4),
    combat = { dam=1 },
}

