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

load "/data/general/objects/swords.lua"
load "/data/general/objects/helmets.lua"
load "/data/general/objects/armors.lua"
load "/data/general/objects/tools.lua"

newEntity{
	define_as = "GRAVITYLENS",
	quest = true, -- not in base?
	plot = true, -- not in base?
	unique = true,
	identified = true, -- not in base?
	name = "Gravity Lens",
	image = "objects/plot/gravitylens.png",
	level_range = {100,100},
	display = "|",
	color = colors.VIOLET,
	notice = true,
	always_remember = true,
	encumber = 0,
	desc = [[A large crystal lens, it seems to warp even the light around it.]],
	on_prepickup = function(self, who)
		print("[DBG] Gravitylens prepickup")
		return false
	end,
	on_pickup = function(self, who)
		print("[DBG] I've been picked up")
		if who == game.player then
			who:setQuestStatus("elemental-quests", engine.Quest.COMPLETED, "earth-quest")
			who.talents_types_mastery["anti-elemental/speed"] = who.talents_types_mastery["anti-elemental/speed"] or 1
			game.logPlayer(who, "#00FFFF#You gain knowledge of the Speed talents!")
			return true
		end
	end,
}
