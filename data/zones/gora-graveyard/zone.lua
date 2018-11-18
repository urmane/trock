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
	name = "Gora Graveyard",
	zone_key = "gora-graveyard",
	level_range = {1, 3},
	max_level = 3,
	decay = {300, 800},
	persistent = "zone",
	ambient_light = 40,
	ambient_music = "creepy-dungeon-ambience.ogg",
	generator =  {
        	map = {
            		class = "engine.generator.map.Static",
        	},
		object = {
			class = "engine.generator.object.Random",
			nb_object = {20, 30},
		},
		up = "UP",
		down = "DOWN",
	},
	levels = {
		[1] = { width = 64, height = 64, generator = { map = { class = "engine.generator.map.Static", map = "zones/gora-graveyard1", }, }, },
		[2] = { width = 64, height = 64, generator = { map = { class = "engine.generator.map.Static", map = "zones/gora-graveyard2", }, }, },
		[3] = { width = 64, height = 64, generator = { map = { class = "engine.generator.map.Static", map = "zones/gora-graveyard3", }, }, },
	},

    post_process = function(l)
        if l.level == 1 then
            -- light fog
            game.state:makeWeatherShader(l, "weather_vapours", {move_factor=160000, evolve_factor=100000, color={0.8, 1, 1, 0.5}, zoom=0.5})
        elseif l.level == 2 then
            game.state:makeWeatherShader(l, "weather_vapours", {move_factor=130000, evolve_factor=90000, color={0.8, 1, 1, 0.7}, zoom=0.5})
        elseif l.level >= 3 then
            -- heavy fog
            game.state:makeWeatherShader(l, "weather_vapours", {move_factor=100000, evolve_factor=80000, color={0.8, 1, 1, 0.9}, zoom=0.3})
        end
    end,

	on_leave = function(lev, old_lev, newzone)
                if lev.level == 1 then
                        -- we know this is the first time through?
                        game.player:setQuestStatus("start", engine.Quest.COMPLETED)
                end
        end,

	on_enter = function(lev, old_lev, newzone)
		if lev and lev == 1 then
			local Dialog = require("engine.ui.Dialog")
			Dialog:simpleLongPopup("Terror", [[Fresh air hits your face like sweet perfume.  You have escaped Gora Prison.

But the cold, the cold is still there, and it's different.  The damp prison cells held the unpleasant bone-numbing chill of water, rock and human cruelty, but this ... this cold is insidious.  Even as you pause to gain your bearings, you feel it creeping over you, slowly, malevolently ... ancient, dark, twisted cold ...

Best not linger here too long.]],400)
			if not game.player:hasQuest("start-escape-graveyard") then
				game.player:grantQuest("start-escape-graveyard")
			end
		end
	end,
}
