
local Talents = require("engine.interface.ActorTalents")

load("/data/general/npcs/base-arachnid.lua")

newEntity{
    base = "BASE_ARACHNID",
	define_as = "BASE_SPIDER",
	keywords = {spider=true},
	type = "spider", --subtype = "prisoner",
	display = "r", color=colors.UMBER,
	desc = [[A spider.]],
	image = "npcs/arachnids/spider.png",
	faction = "animal",
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
}

newEntity{
	base = "BASE_SPIDER",
	name = "spider",
	subtype = "spider",
    image = "npcs/arachnids/spider.png",
	color=colors.UMBER,
	level_range = {1,3}, exp_worth = 1, rarity = 1,
	--lite = 1,
	sight = 6,
	nightvision = 4,
    max_life = resolvers.rngavg(1,4),
    combat = { dam=1 },
}

