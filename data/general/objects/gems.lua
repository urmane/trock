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

local Stats = require "engine.interface.ActorStats"

newEntity{
	define_as = "BASE_GEM",
	type = "gem", subtype="white",
	display = "*", color=colors.YELLOW,
	encumber = 0, slot = "GEM", use_no_wear = true,
	identified = true,
	stacking = true,
	auto_pickup = true, pickup_sound = "actions/gem",
	desc = [[Sparkly bits of polished rock.]],
}

local function newGem(name, image, subtype, cost, rarity, min_level, max_level)
	-- Gems, randomly lootable
	newEntity{ base = "BASE_GEM", define_as = "GEM_"..name:gsub(" ", "_"):upper(),
		name = name:lower(),
		image=image, subtype = subtype, rarity = rarity, cost = cost,
		level_range = {min_level, max_level},
	}
end

-- Groups, species, varieties
-- First, second, or third water
-- perfect, included

-- Organics
newGem("Black Pearl"," object/gem.png", "black", 1000, 100, 8, 10)
newGem("Pearl",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Amber",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Coral",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Ivory",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Jet",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Blue Amber",     "object/gem.png", "white", 1000, 100, 8, 10)

-- Rocks
newGem("Lapis Lazuli", "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Obsidian", "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Jade",     "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Turquoise", "object/gem.png", "white", 1000, 100, 8, 10)

-- Quartzes
newGem("Quartz",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Amethyst",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Citrine",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Jasper",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Tiger-eye",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Opal",     "object/gem.png", "white", 1000, 100, 8, 10)


-- Beryls
newGem("Aquamarine",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Red Beryl",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Goshenite",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Heliodor",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Morganite",   "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Emerald",   "object/gem.png", "white", 1000, 100, 8, 10)

-- Corundums
newGem("Sapphire",  "object/gem.png", "white", 1000, 100, 8, 10)
newGem("Ruby",      "object/gem.png", "white", 1000, 100, 8, 10)

newGem("Diamond",   "object/gem.png", "white", 1000, 100, 8, 10)

--super-rares
-- "Zektzerite"
-- "Serendibite"
-- "Poudrettiete"
-- "Grandidierite"
-- "Musgravite"
-- "Taaffeite"
-- "Chambersite"
-- "Jeremejevite"
-- "Red Beryl"
-- "Hibonite"
-- "Painite"
