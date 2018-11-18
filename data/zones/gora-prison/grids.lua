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

load("/data/general/grids/basic.lua")

newEntity{
        define_as = "SEWER_EXIT",
        always_remember = true,
        show_tooltip=true,
        name="The sewer exit.",
        display='>', color=colors.VIOLET,
	-- image = "terrain/stair_up_wild.png",
        notice = true,
        change_level=1, change_zone="gora-graveyard",
}

-- These are barred gate/doors, not solid, so they do not block sight
newEntity{
        define_as = "CELL_DOOR",
        name = "door", image = "terrain/cell_door_closed1.png",
        display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
        notice = true,
        always_remember = true,
        block_sight = false,
        door_opened = "CELL_DOOR_OPEN",
        dig = "CELL_DOOR_OPEN",
}

newEntity{
        define_as = "CELL_DOOR_OPEN",
        name = "open door", image = "terrain/cell_door_open1.png",
        display = "'", color_r=238, color_g=154, color_b=77, back_color=colors.DARK_GREY,
        always_remember = true,
        door_closed = "CELL_DOOR",
}

-- putting lock_mfctr here makes them all the same for a level ... hm ...
newEntity{
        define_as = "CELL_DOOR_LOCKED",
        name = "locked door", image = "terrain/cell_door_locked1.png",
        display = '+', color_r=238, color_g=154, color_b=77, back_color=colors.DARK_UMBER,
        notice = true,
        always_remember = true,
        block_sight = false,
        door_unlocked = "CELL_DOOR",
        lock_mfctr=game.markov["elvish"]:generateWord("E", 3, 9),
        lock_value = 10,
}

