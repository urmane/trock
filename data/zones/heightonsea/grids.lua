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
load("/data/general/grids/town.lua")
load("/data/general/grids/graveyard.lua")

newEntity{
--    base = "GRAVESTONE",
    define_as = "VERY_OLD_GRAVESTONE",
    name = "a very old gravestone",
    image = "terrain/graveyard/gravestone.png", --add_mos={{image="terrain/troll_stew.png"}},
    display = '^', color=colors.LIGHT_RED, back_color=colors.RED,
    does_block_move = true,
    block_sight = true,
    on_block_bump = function(e)
        -- actor is always player, yes?
    end,
    on_block_bump_msg_title = "Old Gravestone",
    on_block_bump_msg = "You touch the necklace to the very old gravestone",
}

newEntity{
    base = "DOWN",
    define_as = "DOWN",
    image = "terrain/stairs-down.png",
}

newEntity{
    define_as = "FIRE",
    name = "fire",
    image = "terrain/fire.png",
    display = '%', color=colors.LIGHT_RED, back_color=colors.RED,
    does_block_move = true,
    block_sight = false,
}

newEntity{
    define_as = "AIR",
    name = "tornado",
    image = "terrain/tornado.png",
    display = '&', color=colors.YELLOW, back_color=colors.YELLOW,
    does_block_move = true,
    block_sight = false,
}

newEntity{
    define_as = "WATER",
    name = "water",
    image = "terrain/deepwater.png",
    display = '&', color=colors.LIGHT_BLUE, back_color=colors.BLUE,
    does_block_move = true,
    block_sight = false,
}
