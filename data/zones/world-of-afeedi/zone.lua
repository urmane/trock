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

return {
	name = "The World of Afeedi",
	zone_key = "world-of-afeedi",
	level_range = {1, 1},
	max_level = 1,
	decay = {300, 800},
	persistent = "zone",
	width = 256,
	height = 256,
	startx = 15,
	starty = 171,
	endx = 15,
	endy = 171,
	all_lited = true,
    ambient_light = 10,
	-- hidden_zones = ("susrak", "kholbadul"),
	-- first pass - randomly generated world
	-- second pass - add a second underwater "level" based on mirror image of land/water
	generator =  {
        map = {
            class = "mod.class.generator.map.RandomWorld",
			map = "afeedi/afeedi",
			noise = "simplex",
			zoom = 11,
			hurst = 0.16,
			lacunarity = 9,
			octave = 1,
			border_div = 64,          -- border width = width/border_div
			border_terrain = "ocean", -- border terrain
			mountain_height = 0.8,    -- a grid higher than this from the noise generator means mountain
			forest_height = 0.5,    -- using height for forests for the moment
			deepocean_depth = -0.3,   -- a grid less than this from the noise generator means deepocean
			ice_width = 25,           -- north/south pole borders, land->snow ocean->ice
			min_land = 12000,
			-- random terrains
			deepocean = "DEEP_OCEAN",
			ocean = "OCEAN",
			land = "LAND",
	        mountain = "MOUNTAIN",
	        snow = "SNOW",
	        ice = "ICE",
	        trees = "TREES",
	        town1 = "TOWN1",
	        town2 = "TOWN2",
	        town3 = "TOWN3",
	        town4 = "TOWN4",
	        town5 = "TOWN5",
	        town6 = "TOWN6",
	        town7 = "TOWN7",
	        town8 = "TOWN8",
	        town9 = "TOWN9",
	        islol = "ISLOL",
    	},
	},
}

--[[
	post_process = funtion(level)
		This block of code reveals zones on the main map that have prereqs completed
		Could potentially loop through a list of known "X"s:

for X in hidden_zones do
		if player:hasQuest("reveal-X") and not player:hasQuest("reveal-X"):isEnded() then
			local g = game.zone:makeEntityByName(level, "terrain", "X", true)
            print("[DBG] placing X")
            if g then
                local x, y = rng.range(10, level.map.w-11), rng.range(10, level.map.h-11)
                --local x, y = rng.range(10, game.player.x-11), rng.range(10, game.player.y-11)
                local tries = 0
                while (level.map:checkEntity(x, y, engine.Map.TERRAIN, "block_move") or level.map(x, y, engine.Map.OBJECT)) and tries < 100 do
                    x, y = rng.range(10, level.map.w-11), rng.range(10, level.map.h-11)
                    tries = tries + 1
                end
                if tries < 100 then
                    game.zone:addEntity(level, g, "terrain", x, y)
                    print("[DBG]GRAVITYLENS is at %s, %s", x, y)
                    -- Change that print to X is revealed on your map ...
                    level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="zone-pop", subtype="X"} --?
                else
                	-- dunno if we want this here...
                    level.force_recreate = true
                end
            else
                print("[DBG] cannot place X")
            end
            -- this achievement should say "X is now revealed on your map..."
            world:gainAchievement("X-is-revealed", player)
            game.player:setQuestStatus("reveal-X" , engine.Quest.DONE)
        end
  	end
 end,
}
--]]