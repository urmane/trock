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

load("/data/general/npcs/guards.lua")
load("/data/general/npcs/lights.lua")
load("/data/general/npcs/rodents.lua")

load("/data/general/npcs/snakes.lua")
load("/data/general/npcs/spiders.lua")

newEntity{
    base = "BASE_PRISONER", define_as="PRISONER_MACGUFFIN",
    name = "prisoner", color=colors.WHITE,
    desc = "An old man, withered and near death.",
    level_range = {1, 4}, exp_worth = 0, rarity = 1,
    lite = 1, -- required for now to make him visible, without a lightsource
    -- not sure which of these applies in the generic engine
    --never_move = 1,
    ai = "none",
    faction = "neutral",
    can_talk = "double-macguffin-prisoner1",
}

