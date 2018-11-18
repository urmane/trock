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
    define_as = "GRASS",
    type = "floor", subtype = "grass",
    name = "grass",
    image = "terrain/graveyard/grass.png", --add_mos={{image="terrain/troll_stew.png"}},
    display = '.', color=colors.DARK_GREEN, back_color=colors.DARK_GREEN,
    does_block_move = false,
	block_sight = false,
}
newEntity{
    define_as = "DIRT_PATH",
    type = "floor", subtype = "dirt",
    name = "dirt path",
    image = "terrain/dirtpath.png", --add_mos={{image="terrain/troll_stew.png"}},
    display = '.', color=colors.UMBER, back_color=colors.UMBER,
    does_block_move = false,
	block_sight = false,
}

newEntity{
    define_as = "DEEP_WATER",
    type = "wall", subtype = "water",
    name = "deep water", -- image = "terrain/grass.png", add_mos={{image="terrain/troll_stew.png"}},
    display = '~', color=colors.DARK_BLUE, back_color=colors.DARK_GREY,
    does_block_move = false,
	block_sight = false,
}

newEntity{
        define_as = "FENCE",
        type = "wall", subtype = "fence",
        name = "iron fence", -- image = "terrain/grass.png", add_mos={{image="terrain/troll_stew.png"}},
        display = '=', color=colors.LIGHT_RED, back_color=colors.RED,
        does_block_move = true,
	block_sight = false,
}

newEntity{
        define_as = "GRAVESTONE",
        type = "wall", subtype = "gravestone",
        name = "huge gravestone", -- image = "terrain/grass.png", add_mos={{image="terrain/troll_stew.png"}},
        display = '^', color=colors.LIGHT_RED, back_color=colors.RED,
        does_block_move = true,
	block_sight = true,
}

newEntity{
        define_as = "TREE",
        type = "wall", subtype = "tree",
        name = "thick gnarled tree",
        image = "terrain/town/tree.png",
        display = '#', color=colors.LIGHT_GREEN, back_color={r=44,g=95,b=43},
        always_remember = true,
        does_block_move = true,
        block_sight = true,
--        block_sense = true,
--        block_esp = true,
}

newEntity{
        define_as = "GRAVEYARD_EXIT",
        always_remember = true,
        show_tooltip=true,
        name="The bridge to town.",
        display='>', color=colors.VIOLET,
        -- image = "terrain/stair_up_wild.png",
        notice = true,
        change_level=1, change_zone="gora-town",
}
