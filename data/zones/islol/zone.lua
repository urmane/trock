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
	name = "The Temple of Islol",
	zone_key = "islol",
	level_range = {1, 1},
	max_level = 1,
	decay = {300, 800},
	persistent = "zone",
	ambient_light = 60,
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
		[1] = { width = 64, height = 64, generator = { map = { class = "engine.generator.map.Static", map = "zones/islol1", }, }, },
	},
}
