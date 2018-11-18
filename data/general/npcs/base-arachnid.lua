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

load("/data/general/npcs/base-animal.lua")

newEntity{
	base = "BASE_ANIMAL",
	define_as = "BASE_ARACHNID",
    keywords = {arachnid=true},
	display = "X",
    color=colors.WHITE,
	image = "npcs/arachnids/spider.png",
	stats = { str=1, dex=1, con=1 },
	combat_armor = 0,
    sight = 2,
    nightvision = 0,
}
