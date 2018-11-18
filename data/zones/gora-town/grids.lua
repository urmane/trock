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
load("/data/general/grids/sign.lua")

newEntity{
        define_as = "TO_GRAVEYARD",
        always_remember = true,
        show_tooltip=true,
        name="The bridge to the graveyard.",
        display='>', color=colors.VIOLET,
        -- image = "terrain/stair_up_wild.png",
        notice = true,
        change_level=1, change_zone="gora-graveyard",
}

newEntity{
        define_as = "TO_CASTLEKURTOK",
        always_remember = true,
        show_tooltip=true,
        name="The stairs to the castle.",
        display='>', color=colors.VIOLET,
        -- image = "terrain/stair_up_wild.png",
        notice = true,
        change_level=1, change_zone="castle-kurtok",
}

newEntity{
        base = "DOOR_OPEN",
    define_as = "DOOR_HOUSE",
    name = "house door",
    on_move = function(self, x, y, who)
        require("engine.ui.Dialog"):yesnoPopup("This is a house",
                "You can choose to spend X gold on equipment to loot this house for random return.",
                function(ret)
            if ret then return end
            --local o = game.zone:makeEntityByName(game.level, "object", "CORRUPTED_SANDQUEEN_HEART", true)
            if true then
                game.log("#GREEN#You burgle the house.")
            end
        end, "Leave", "Burgle", nil, true)
    end,
}
