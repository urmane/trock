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

subGenerator{
    x = 0, y = 128, w = 64, h = 64,
    generator = "engine.generator.map.Static",
    data = {
    	map = "afeedi/afeedi-start",
        land = "LAND",
        ocean = "OCEAN",
        trees = "TREES",
        mountain = "MOUNTAIN",
	snow = "SNOW",
	ice = "ICE",
    },
}

-- Entire world
addZone({1, 1, 255, 255}, "zonename", "Afeedi")

-- Special towns
addZone({1,1,255,25}, "town", "static", {"town1"})
addZone({1,26,255,50}, "town", "static", {"town2"})
addZone({1,51,255,75}, "town", "static", {"town3"})
addZone({1,76,255,100}, "town", "static", {"town4"})
addZone({1,101,255,126}, "town", "static", {"town5"})
addZone({1,126,255,150}, "town", "static", {"town6"})
addZone({65,151,255,175}, "town", "static", {"town7"})
addZone({65,176,255,200}, "town", "static", {"town8"})
addZone({1,201,255,255}, "town", "static", {"town9"})

-- Random towns
addZone({1,1,255,255}, "town", "random", {"rtown1"})
addZone({1,1,255,255}, "town", "random", {"rtown2"})
addZone({1,1,255,255}, "town", "random", {"rtown3"})
addZone({1,1,255,255}, "town", "random", {"rtown4"})
addZone({1,1,255,255}, "town", "random", {"rtown5"})
addZone({1,1,255,255}, "town", "random", {"rtown6"})
addZone({1,1,255,255}, "town", "random", {"rtown7"})
addZone({1,1,255,255}, "town", "random", {"rtown8"})
addZone({1,1,255,255}, "town", "random", {"rtown9"})

-- Special dungeons
addZone({65,150,255,170}, "dungeon", "static", {"islol"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon1"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon2"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon3"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon4"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon5"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon6"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon7"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon8"})
addZone({1,1,255,255}, "dungeon", "static", {"dungeon9"})

-- Random dungeons
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon1"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon2"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon3"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon4"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon5"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon6"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon7"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon8"})
addZone({1,1,255,255}, "dungeon", "random", {"rdungeon9"})

-- People to meet (usually a dialogue on-map)
--prepareEntitiesList("afeedi_map_npcs", "mod.class.WorldNPC", "/data/general/encounters/afeedi-map-npcs.lua")
addZone({1,1,2,2}, "world_npc", "afeedi-map-npcs")
addZone({3,3,64,64}, "world_npc", "afeedi-map-npcs")

-- Encounters to have (usually a zone the player falls into)
--prepareEntitiesList("afeedi_map_encounters", "mod.class.Encounter", "/data/general/encounters/afeedi-map-encounters.lua")

--

-- sample code from tome, example of stuff to put in map generator
-- Load encounters for this map
--prepareEntitiesList("maj_eyal_encounters", "mod.class.Encounter", "/data/general/encounters/maj-eyal.lua")
--prepareEntitiesList("maj_eyal_encounters_npcs", "mod.class.WorldNPC", "/data/general/encounters/maj-eyal-npcs.lua")
--prepareEntitiesList("fareast_encounters", "mod.class.Encounter", "/data/general/encounters/fareast.lua")
--prepareEntitiesList("fareast_encounters_npcs", "mod.class.WorldNPC", "/data/general/encounters/fareast-npcs.lua")
--addData{
--    wda = { script="eyal", zones={} },
--    auto_placelists = { "maj_eyal_encounters", "fareast_encounters" },
--}



return true
