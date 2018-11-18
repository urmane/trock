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

-- thief's tools, diggers, climber, gemcutter? holy symbol, writing(scroll?), pole (why?), mechanism/device, flint-and-steel

--local FlyingText = require "engine.FlyingText"
--local Talents = require "engine.interface.ActorTalents"

newEntity{
    define_as = "BASE_LOCKPICK",
    slot = "TOOL",
    type = "tool", subtype="lockpick",
    display = "/",
    color=colors.SLATE,
    encumber = 3,
    rarity = 5,
    -- combat = { sound = "actions/lockpick", sound_miss = "actions/melee_miss", },
    name = "a generic lockpick",
    desc = [[One or more strong, shaped wires or keys used to open locks.]],
    use_simple = {
        name = "Unlock that which is locked.",
		use = function(self, who)
	    	-- change range to talent range
            local tg = {type="bolt", range=1, nolock=true}
            local x, y = who:getTarget(tg)
            if not x or not y then return nil end
			local door = game.level.map(x, y, engine.Map.TERRAIN) -- only works on doors (TERRAIN) right now
			if door.door_unlocked then
				lock_value = door.lock_value or 10
				skill_total = self.bonus or 0
				if who:knowTalent(engine.interface.ActorTalents.T_LOCKPICK) then
					skill_total = skill_total + who:getTalentLevel(engine.interface.ActorTalents.T_LOCKPICK)
				end
				-- short term, simple test - more complicated later with ui, or maybe allow ui on test fail
				if lock_value <= skill_total then -- possibly allow a random chance, too?
					print("unlocking at ", x, ",", y)
					print("lock_mfctr is ", door.lock_mfctr or "none")
					game.level.map(x, y, engine.Map.TERRAIN, game.zone.grid_list[door.door_unlocked])
					local sx, sy = game.level.map:getTileToScreen(x, y)
					game.flyers:add(sx, sy, 10, 0, -1, "Unlocked!", {0,255,0}, false)
				else
					print("failed to unlock at ", x, ",", y)
					local sx, sy = game.level.map:getTileToScreen(x, y)
					game.flyers:add(sx, sy, 10, 0, -1, "Fail!", {255,0,0}, false)
				end
			-- regardless of success, bump skill counter based on lock difficulty
			else
				print("Attempt to lockpick a terrain that is not an unlockable door at", x, ",", y)
				-- maybe popup err msg here
			end
            return {id=true, used=true}
        end
    },
}

newEntity{ base = "BASE_LOCKPICK", name = "makeshift lockpick",             level_range = {1, 10}, cost = 1, bonus = 10, }
newEntity{ base = "BASE_LOCKPICK", name = "lockpick",                       level_range = {1, 10}, cost = 1, bonus = 20, }
newEntity{ base = "BASE_LOCKPICK", name = "skelton key",                    level_range = {1, 10}, cost = 1, bonus = 30, }
newEntity{ base = "BASE_LOCKPICK", name = "professional's lockpicks",       level_range = {1, 10}, cost = 1, bonus = 40, }
newEntity{ base = "BASE_LOCKPICK", name = "locksmith's tools",              level_range = {1, 10}, cost = 1, bonus = 50, }
newEntity{ base = "BASE_LOCKPICK", name = "thief's tools",                  level_range = {1, 10}, cost = 1, bonus = 60, }
newEntity{ base = "BASE_LOCKPICK", name = "master thief's tools",           level_range = {1, 10}, cost = 1, bonus = 70, }
