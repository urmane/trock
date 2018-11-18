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
	define_as = "BASE_TOWNPERSON",
	type = "humanoid", subtype = "townperson",
	display = "p", color=colors.WHITE,
	desc = [[A good citizen, salt of the earth.]],
	image = "npcs/town/townperson.png",
	faction = "neutral",
	ai = "townperson",
	stats = { str=1, dex=1, con=1 },
	combat_armor = 0,
}

newEntity{
	base = "BASE_TOWNPERSON",
	name = "townperson", 
	color=colors.WHITE,
	level_range = {1,3}, exp_worth = 1, rarity = 1,
	lite = 3,
	sight = 3,
	nightvision = 40,
	max_life = 1,
}
