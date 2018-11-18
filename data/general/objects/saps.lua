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

newEntity{
    define_as = "BASE_SAP", slot = "WEAPON",
    type = "weapon", subtype="sap", display = "/", color=colors.UMBER,
    encumber = 1, rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic sap",
    desc = [[A weighted stick used to render unconscious the unsuspecting.]],
}

newEntity{ base = "BASE_SAP", name = "leather sap",     level_range = {1, 10}, cost = 5, combat = { dam = 10, }, }
newEntity{ base = "BASE_SAP", name = "lead sap",     level_range = {1, 10}, cost = 5, combat = { dam = 10, }, }
newEntity{ base = "BASE_SAP", name = "leather blackjack",     level_range = {1, 10}, cost = 5, combat = { dam = 10, }, }
newEntity{ base = "BASE_SAP", name = "lead blackjack",     level_range = {1, 10}, cost = 5, combat = { dam = 10, }, }
