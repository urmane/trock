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

-- Decoration - useless(?) objects
newEntity{
	define_as = "BASE_DECORATION",
	type = "decoration", --subtype="white",
	display = ";", color=colors.YELLOW,
	encumber = 1, use_no_wear = true,
	identified = true,
	stacking = true,
	-- auto_pickup = true, pickup_sound = "actions/gem",
	desc = [[A bit of decoration.]],
}

local function newDecoration(name, image, subtype, enc, rarity, min_level, max_level)
	-- Gems, randomly lootable
	newEntity{ base = "BASE_DECORATION", define_as = "DECORATION_"..name:gsub(" ", "_"):upper(),
		name = name:lower(),
		image=image, subtype = subtype, rarity = rarity, encumber = enc,
		level_range = {min_level, max_level},
	}
end

newDecoration("chair", "object/decorations/chair.png", "furniture", 10, 1, 1, 10)
newDecoration("table", "object/decorations/table.png", "furniture", 20, 1, 1, 10)

