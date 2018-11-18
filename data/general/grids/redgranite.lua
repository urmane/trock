
newEntity{
	define_as = "TO_WORLDMAP",
	name = "Exit to the World Map",
	display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_RED,
	always_remember = true,
	notice = true,
	change_level = 1,
	change_zone = "world-of-afeedi",
}

newEntity{
	define_as = "UP",
	name = "previous level",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_RED,
	notice = true,
	always_remember = true,
	change_level = -1,
}

newEntity{
	define_as = "DOWN",
	name = "next level",
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_RED,
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "FLOOR",
	name = "floor", image = "terrain/redgranite/floor_1.png",
	display = '.', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	always_remember = true,
}

newEntity{
	define_as = "WALL",
	name = "wall", image = "terrain/redgranite/wall_1.png",
	display = '#', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	always_remember = true,
	does_block_move = true,
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "WALLGRATE",
	name = "wall", image = "terrain/redgranite/wallgrate_1.png",
	display = '#', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	always_remember = true,
	does_block_move = true,
	block_sight = false,
	can_pass = {pass_wall=1},
	dig = "FLOOR",
}

newEntity{
	define_as = "LAVA",
	name = "lava", image = "terrain/lava.png",
	display = '~', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
}


newEntity{
	define_as = "DOOR",
	name = "door", image = "terrain/redgranite/door_closed.png",
	display = '+', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "terrain/redgranite/door_open.png",
	display = "'", color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	always_remember = true,
	door_closed = "DOOR",
}

-- putting lock_mfctr here makes them all the same for a level ... hm ...
newEntity{
	define_as = "DOOR_LOCKED",
	name = "locked door", image = "terrain/redgranite/door_closed.png",
	display = '+', color_r=255, color_g=0, color_b=0, back_color=colors.DARK_RED,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_unlocked = "DOOR",
	lock_mfctr=game.markov["elvish"]:generateWord("E", 3, 9),
	lock_value = 10,
}

