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

local Talents = require("engine.interface.ActorTalents")

newEntity{
	define_as = "BASE_WISP",
	type = "undead", subtype = "wisp",
	display = "W", color=colors.WHITE,
	desc = [[A small light, strangely compelling ...]],

	--ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	ai = "move_wander",
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
}

newEntity{ base = "BASE_WISP",
	name = "will-o-wisp", color=colors.GREEN,
    image = "npcs/lights/willowisp.png",
	level_range = {1, 4}, exp_worth = 1,
	rarity = 4,
	lite = 1,		-- radius of the light this actor puts out
	lite_pulse = 90,        -- percent chance per turn to mod lite
	lite_pulse_step = 1,    -- amount and step to inc/dec
	lite_min = 0,           -- min radius
	lite_max = 3,           -- max radius
	sight = 5,		-- absolute limit of sight
	nightvision = 5,		-- minimum light level this actor can distinguish
	max_life = resolvers.rngavg(5,9),
	combat = { dam=1 },
}

