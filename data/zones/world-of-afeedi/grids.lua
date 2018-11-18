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
    define_as = "TREES",
    type = "wall", subtype = "tree",
    name = "trees",
    image = "terrain/world/forest.png",
    display = '+', color=colors.LIGHT_GREEN, back_color={r=44,g=95,b=43},
    always_remember = true,
    does_block_move = false,
    block_sight = false, --        block_sense = true, --        block_esp = true,
}

newEntity{
    define_as = "DEEP_OCEAN",
    type = "wall", subtype = "grass",
    name = "deepocean",
	image = "terrain/world/deepocean.png",
    display = '~', color=colors.DARK_BLUE, back_color={r=0,g=0,b=255},
    always_remember = true,
    does_block_move = false,
    --does_block_move = true,
    block_sight = false, --        block_sense = true, --        block_esp = true,
}

newEntity{
    define_as = "OCEAN",
    type = "wall", subtype = "grass",
    name = "ocean",
	image = "terrain/world/ocean.png",
    display = '~', color=colors.LIGHT_BLUE, back_color={r=0,g=0,b=255},
    always_remember = true,
    does_block_move = false,
    --does_block_move = true,
    block_sight = false, --        block_sense = true, --        block_esp = true,
}

newEntity{
    define_as = "LAND",
    type = "floor", subtype = "grass",
    name = "land",
	image = "terrain/world/plains.png",
    display = '.', color=colors.TAN, back_color={r=100,g=100,b=100},
    always_remember = true,
    does_block_move = false,
    block_sight = false,
}

newEntity{
    define_as = "MOUNTAIN",
    type = "wall", subtype = "grass",
    name = "mountain",
	image = "terrain/world/mountains.png",
    display = '^', color=colors.LIGHT_UMBER, back_color={r=80,g=80,b=40},
    always_remember = true,
    does_block_move = true,
    block_sight = true,
}

newEntity{
    define_as = "SNOW",
    type = "wall", subtype = "grass",
    name = "snow", --        image = "terrain/land.png",
    display = '.', color=colors.WHITE, back_color={r=250,g=250,b=255},
    always_remember = true,
    does_block_move = false,
    block_sight = false,
}

newEntity{
    define_as = "ICE",
    type = "wall", subtype = "grass",
    name = "ice", --        image = "terrain/land.png",
    display = '~', color=colors.WHITE, back_color={r=200,g=200,b=255},
    always_remember = true,
    does_block_move = false,
    block_sight = true,
}

newEntity{
    define_as = "KHOLBADUL",
    type = "wall", subtype = "grass",
    name = "Kholbadul", --        image = "terrain/land.png",
    display = '^', color=colors.RED, back_color={r=100,g=0,b=0},
    always_remember = true,
    does_block_move = false, -- cuz we move onto it
    block_sight = true,
    change_level=1, change_zone="kholbadul",
}

newEntity{
    define_as = "SUSRAK",
    type = "wall", subtype = "grass",
    name = "Tomb of Susrak", --        image = "terrain/land.png",
    display = '^', color=colors.RED, back_color={r=100,g=0,b=0},
    always_remember = true,
    does_block_move = false, -- cuz we move onto it
    block_sight = false,
    change_level=1, change_zone="susrak",
}

newEntity{
    define_as = "GORA",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    name="The town of Gora.",
    display='G', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="gora-town",
}

newEntity{
    define_as = "HEIGHTONSEA",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    name="The town of Heightonsea.",
    display='H', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="heightonsea",
}

newEntity{
    define_as = "MURMON",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    name="Murmon",
    display='M', color=colors.VIOLET,
    image = "terrain/world/dungeon.png",
    notice = true,
    change_level=1, change_zone="murmon",
}

newEntity{
    define_as = "CASTLE_ZALA",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    name="The Castle Zala.",
    display='Z', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="castle-zala",
}

newEntity{
    define_as = "TOWN1",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town1",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='1', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town1",
}

newEntity{
    define_as = "TOWN2",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town2",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='2', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town2",
}

newEntity{
    define_as = "TOWN3",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town3",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='3', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town3",
}

newEntity{
    define_as = "TOWN4",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town4",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='4', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town4",
}

newEntity{
    define_as = "TOWN5",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town5",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='5', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town5",
}

newEntity{
    define_as = "TOWN6",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town6",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='6', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town6",
}

newEntity{
    define_as = "TOWN7",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town7",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='7', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town7",
}

newEntity{
    define_as = "TOWN8",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
--        name="town8",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='8', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town8",
}

newEntity{
    define_as = "TOWN9",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    --name="town9",
    name=game.markov["elvish"]:generateWord("E", 3, 9),
    display='9', color=colors.VIOLET,
    image = "terrain/world/town.png",
    notice = true,
    change_level=1, change_zone="town9",
}

newEntity{
    define_as = "ISLOL",
    type = "floor", subtype = "grass",
    always_remember = true,
    show_tooltip=true,
    name="The Temple of Islol",
    display='T', color=colors.VIOLET,
    image = "terrain/world/dungeon.png",
    notice = true,
    change_level=1, change_zone="islol",
}

