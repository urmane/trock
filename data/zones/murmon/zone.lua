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
	name = "Murmon",
	zone_key = "murmon",
	level_range = {1, 1},
	max_level = 3,
	decay = {300, 800},
	persistent = "zone",
	ambient_light = 1,
    width = 64, height = 64,
	generator =  {
        map = {
            class = "engine.generator.map.Cavern",
            zoom = 5 , --zoom = 30,
            up = "UP",
            down = "DOWN",
            wall = "WALL",
            floor = "FLOOR",
            door = "FLOOR",
        },
		object = {
			class = "engine.generator.object.Random",
			nb_object = {20, 30},
		},
        actor = {
           class = "engine.generator.actor.Random",
           nb_npc = {45, 50},
        },
  --       trap = {
  --          class = "engine.generator.trap.Random",
  --          nb_trap = {0, 0},
  --       },
	},
	levels = {
		[1] = {
            ambient_light = 3,
            generator = { map = {
                up = "TO_WORLDMAP",
            }, },
        },
        [2] = {
            ambient_light = 2,
            generator = { map = {
                --width = 256, height = 256,
                width = 32, height = 32,
                zoom = 20,
            }, },
        },
        [3] = {
            ambient_light = 1,
            no_level_connectivity = true,
            generator = { map = {
                --width = 256, height = 256,
                width = 32, height = 32,
                zoom = 10,
            }, },
        },
	},
    post_process = function(level)
        --if level.level == 1 then
            local g = game.zone:makeEntityByName(level, "object", "GRAVITYLENS", true)
            print("[DBG]testtest")
            if g then
                local x, y = rng.range(10, level.map.w-11), rng.range(10, level.map.h-11)
                --local x, y = rng.range(10, game.player.x-11), rng.range(10, game.player.y-11)
                local tries = 0
                --
                -- Um, do I need this?  this is not a terrain...
                -- Yes, duh, otherwise player cannot pick it up
                while (level.map:checkEntity(x, y, engine.Map.TERRAIN, "block_move") or level.map(x, y, engine.Map.OBJECT)) and tries < 100 do
                    x, y = rng.range(10, level.map.w-11), rng.range(10, level.map.h-11)
                    tries = tries + 1
                end
                if tries < 100 then
                    game.zone:addEntity(level, g, "object", x, y)
                    print("[DBG]GRAVITYLENS is at %s, %s", x, y)
                    level.spots[#level.spots+1] = {x=x, y=y, check_connectivity="entrance", type="special", subtype="artifact"} --?
                else
                    level.force_recreate = true
                end
            else
                print("[DBG] cannot make gravitylens")
            end
        --end
    end,
--	on_leave = function(lev, old_lev, newzone)
--                if lev.level == 1 then
--                        -- we know this is the first time through?
--                        game.player:setQuestStatus("start", engine.Quest.COMPLETED)
--                end
--        end,
--	on_enter = function(lev, old_lev, newzone)
--		--if lev.level == 3 then
--		if lev and lev == 3 then
--			local Dialog = require("engine.ui.Dialog")
--			Dialog:simpleLongPopup("Terror", [[Best not linger here too long.]],400)
--			if not game.player:hasQuest("start-escape-graveyard") then
--				game.player:grantQuest("start-escape-graveyard")
--			end
--		end
--	end,
}
