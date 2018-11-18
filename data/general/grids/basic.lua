-- ITS - In The Shadows
-- Copyright (C) 2015, 2016, 2017 James Niemira
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- James Niemira "urmane"
-- jim.niemira@gmail.com

newEntity{
	define_as = "TO_WORLDMAP",
	name = "Exit to the World Map",
	display = '<', color_r=255, color_g=0, color_b=255, back_color=colors.DARK_GREY,
	always_remember = true,
	notice = true,
	change_level = 1,
	change_zone = "world-of-afeedi",
}

newEntity{
	define_as = "UP",
	name = "previous level",
	display = '<', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = -1,
}

newEntity{
	define_as = "DOWN",
	name = "next level",
	display = '>', color_r=255, color_g=255, color_b=0, back_color=colors.DARK_GREY,
	notice = true,
	always_remember = true,
	change_level = 1,
}

newEntity{
	define_as = "FLOOR",
	name = "floor", image = "terrain/granite/floor_1.png",
	display = ' ', color_r=255, color_g=255, color_b=255, back_color=colors.DARK_GREY,
}

newEntity{
	define_as = "WALL",
	name = "wall", image = "terrain/granite/wall_1.png",
	display = '#', color_r=255, color_g=255, color_b=255, back_color=colors.GREY,
	always_remember = true,
	does_block_move = true,
	on_block_bump = function(e)
	end,
	on_block_bump_msg = "You bump the wall.",
	can_pass = {pass_wall=1},
	block_sight = true,
	air_level = -20,
	dig = "FLOOR",
}

newEntity{
	define_as = "WALLGRATE",
	name = "wall", image = "terrain/granite_wallgrate1.png",
	display = '#', color_r=255, color_g=255, color_b=255, back_color=colors.GREY,
	always_remember = true,
	does_block_move = true,
	block_sight = false,
	can_pass = {pass_wall=1},
	dig = "FLOOR",
}

newEntity{
	define_as = "DEEP_WATER",
	name = "deep_water", image = "terrain/deepwater.png",
	display = '~', color_r=0, color_g=0, color_b=255, back_color=colors.DARK_BLUE,
}

newEntity{
	define_as = "DOOR",
	name = "door", image = "terrain/granite_door_closed.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_opened = "DOOR_OPEN",
	dig = "DOOR_OPEN",
}

newEntity{
	define_as = "DOOR_OPEN",
	name = "open door", image = "terrain/granite_door_open.png",
	display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
	always_remember = true,
	door_closed = "DOOR",
}

-- putting lock_mfctr here makes them all the same for a level ... hm ...
newEntity{
	define_as = "DOOR_LOCKED",
	name = "locked door", image = "terrain/granite_door_closed.png",
	display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
	notice = true,
	always_remember = true,
	block_sight = true,
	door_unlocked = "DOOR",
	lock_mfctr=game.markov["elvish"]:generateWord("E", 3, 9),
	lock_value = 10,
}

