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
	define_as = "BASE_NPC_KOBOLD",
	type = "humanoid", subtype = "kobold",
	display = "k", color=colors.WHITE,
	desc = [[Ugly and green!]],
	lite = 4,

	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
}

}

newEntity{ base = "BASE_NPC_KOBOLD",
	name = "armoured kobold warrior", color=colors.AQUAMARINE,
	level_range = {6, 10}, exp_worth = 1,
	rarity = 4,
	max_life = resolvers.rngavg(10,12),
	combat_armor = 3,
	combat = { dam=5 },
}

newEntity{
        define_as = "BASE_DRAGON",
        type = "dragon", subtype="white",
        display = "D", color=colors.WHITE,
	level_range = {1, 4}, exp_worth = 1,
        rarity = 4,
	ai = "dumb_talented_simple", ai_state = { talent_in=3, },
	stats = { str=5, dex=5, con=5 },
        max_life = resolvers.rngavg(5,9),
        combat = { dam=2 },
}

-- the type and subtype should be sufficient for anything that needs to target specific genus/species
-- the remaining flags should be sufficient for targeting large classes
--
local function newX(name, image, subtype, color, rarity, min_level, max_level, str, sns, ndr)
        newEntity{
		base = "BASE_DRAGON", --define_as = "GEM_"..name:gsub(" ", "_"):upper(),
                name = name:lower(),
                image=image, subtype = subtype, rarity = rarity, color=color,
                level_range = {min_level, max_level},
		stats = { str = str, sns = sns, ndr = ndr },
		is_living = true,
		is_flesh = true,
		is_reptile = true,
        }
end

newX("Black dragon hatchling","npcs/blackdragon.png", "black", colors.BLACK, 1, 1, 10, 10, 10, 10)

