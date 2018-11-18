newEntity{
	define_as = "BASE_ZOMBIE",
	type = "undead", subtype = "zombie",
	display = "z", color=colors.WHITE,
	desc = [[The dead walk!!!]],
	--image = "npcs/Trolldoll2.png",

	--ai = "guard_wander",
	ai = "move_wander", ai_state = { talent_in=3, },
	global_speed_base = 0.5,
	stats = { str=5, dex=5, con=5 },
	combat_armor = 1,
}

newEntity{ base = "BASE_ZOMBIE",
	name = "zombie", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 1,
    image = "npcs/undead/zombie.png",
	rarity = 1,
	lite = 0,		-- radius of the light this actor puts out
	sight = 4,		-- absolute limit of sight
	nightvision = 10,		-- minimum light level this actor can distinguish
	max_life = resolvers.rngavg(5,9),
	combat = { dam=2 },
}

