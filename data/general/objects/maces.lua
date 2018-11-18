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
    define_as = "BASE_HAMMER", slot = "WEAPON",
    type = "weapon", subtype="hammer", display = "/", color=colors.SLATE,
    encumber = 3,
    rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", type = "blunt", damage = "physical"},
    name = "a generic hammer",
    desc = [[A heavy, blunt instrument to knock things about.]],
}

local function newSword(name, levmin, levmax, cost, d)
newEntity{
	base = "BASE_SWORD",
	name = name.." sword",
	level_range = {levmin, levmax},
	cost = cost,
	combat = { dam = d, },
}
end

newSword("brass",    1, 10, 1, 10)
newSword("bronze",   1, 10, 1, 10)
newSword("iron",     1, 10, 2, 20)
newSword("steel",    1, 10, 3, 30)
newSword("coral",    1, 10, 4, 40)
newSword("crystal",  1, 10, 5, 50)
newSword("carnite",  1, 10, 6, 60)
newSword("arkidine", 1, 10, 7, 70)
newSword("energy",   1, 10, 8, 80)
newSword("power",    1, 10, 9, 90)
newSword("force",    1, 10, 10, 100)
newSword("nanite",   1, 10, 11, 110)
newSword("gravity",  1, 10, 12, 120)
newSword("null",     1, 10, 13, 130)

