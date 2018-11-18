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

newEntity{
	define_as = "BASE_PRISONER",
	type = "humanoid", subtype = "prisoner",
	display = "P", color=colors.WHITE,
	desc = [[A wretched, tortured mess of rags and flesh.]],
	image = "npcs/prisoners/prisoner.png",
	faction = "neutral",
	stats = { str=1, dex=1, con=1 },
	combat_armor = 0,
}

newEntity{
	base = "BASE_PRISONER",
	name = "prisoner", 
	color=colors.WHITE,
	level_range = {1,3}, exp_worth = 1, rarity = 1,
	ai = "prisoner", -- ai_state = { talent_in=3, },
	lite = 0,
	sight = 3,
	nightvision = 3, -- prisoners see better than guards
	scent = 99, -- stinky!
	max_life = 1,
}

newEntity{
	define_as = "BASE_GUARD",
	type = "humanoid", subtype = "guard",
	display = "G", color=colors.WHITE,
	desc = [[Ugly and ill-tempered.]],
	image = "npcs/Trolldoll2.png",
	-- ai = "dumb_talented_simple", ai_state = { talent_in=3, },
    normal_speed = 0.33,
    pursuit_speed = 0.9,
	global_speed = 0.33,
	ai = "its_guard_wander",
	stats = { str=5, dex=5, con=5 },
	combat_armor = 0,
    on_acquire_target = function(act)
        if act.x and act.y then
            local sx, sy = game.level.map:getTileToScreen(act.x, act.y)
            game.flyers:add(sx, sy, 20, 0, -1, "Halt!", {255,0,0}, false)
        end
    end,
}

newEntity{ base = "BASE_GUARD",
	name = "prisonguard", color=colors.GREEN,
	level_range = {1, 4}, exp_worth = 1,
	rarity = 4,
	lite = 5,		-- radius of the light this actor puts out
    lite_flicker = 90,      -- percent chance per turn to mod lite
    lite_min = 3,           -- min radius
    lite_max = 5,           -- max radius
	move_dir = 2,	-- initial move direction, they'll rotate clockwise 90 degrees for now
	lite_angle = 90,-- angle of light projected, in direction move_dir
	sight = 5,		-- absolute limit of sight in grids
	nightvision = 0,	-- max ambient light level this actor can distinguish
	scent = 99, -- how much scent I leave
	noise_made = 0, -- how much noise I made this past turn
	vibration_made = 0,
	move_speed = "normal", -- set by AI to stop/slow/normal/fast
	-- movev = {
	--    [MoveType.SLOW] = 0,
	--    [MoveType.NORMAL] = {},
    --}


	--movev = {
	--   "stop" = {},
	--   "slow" = {
	--      noise = 1,
	--      vibration = 1,
	--      sounds = {"file", "file", "...", },
	--   },
    --},
	

	-- act_sounds = {
	-- }
	max_life = resolvers.rngavg(5,9),
	combat = { dam=2 },
}

newEntity{ base = "BASE_GUARD",
	name = "eliteprisonguard", color=colors.BLUE,
	level_range = {2, 5}, exp_worth = 2,
	rarity = 4,
	lite = 5,		-- radius of the light this actor puts out
    lite_flicker = 90,      -- percent chance per turn to mod lite
    lite_min = 3,           -- min radius
    lite_max = 5,           -- max radius
	sight = 5,		-- absolute limit of sight in grids
	nightvision = 0,	-- minimum light level this actor can distinguish
	move_dir = 2,	-- initial move direction, they'll rotate clockwise 90 degrees for now
	lite_angle = 90,-- angle of light projected, in direction move_dir
	max_life = resolvers.rngavg(5,9),
	combat = { dam=2 },
}

