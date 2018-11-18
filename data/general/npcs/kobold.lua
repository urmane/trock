local Talents = require("engine.interface.ActorTalents")

load("/data/ganeral/npcs/base-humanoid.lua")

newEntity{
    base = "BASE_HUMANOID",
	define_as = "KOBOLD",
	type = "humanoid",
	subtype = "kobold",
	display = "k",
	image = "npcs/kobold.png",
	color=colors.WHITE,
	back_color=colors.BLACK,
	desc = [[Ugly and green!]],
	lite = 4,
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
	egos = "/data/general/npcs/egos/kobold.lua",
	egos_chance = { prefix=resolvers.mbonus(40, 5), suffix=resolvers.mbonus(40, 5) },
	-- force_ego = {"of projection"}
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "kobold warrior", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 1,
	rarity = 4,
	max_life = resolvers.rngavg(5,9),
	combat = { dam=2 },
}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "armoured kobold warrior", color=colors.AQUAMARINE,
	level_range = {6, 10}, exp_worth = 1,
	rarity = 4,
	max_life = resolvers.rngavg(10,12),
	combat_armor = 3,
	combat = { dam=5 },
}
