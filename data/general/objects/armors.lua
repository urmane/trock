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
    define_as = "BASE_SUITARMOR", slot = "TORSO", slot_forbid = "ARMS",
    type = "armor", subtype="suit", display = "/", color=colors.SLATE,
    encumber = 3, rarity = 5,
    combat = { sound = "actions/melee", sound_miss = "actions/melee_miss", },
    name = "a generic armor",
    desc = [[A crunchy shell.]],
}

local function newArmor(name, image, color, cost, enc, rarity, min_level, max_level, def, armor)
        newEntity{ base = "BASE_SUITARMOR", --define_as = "GEM_"..name:gsub(" ", "_"):upper(),
                name = name:lower().." armor",
                image = image, color = color, rarity = rarity, cost = cost, encumber = enc,
                level_range = {min_level, max_level},
        }
end

newArmor("leather", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("hide",    "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("wood",    "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("brass",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("bronze",  "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("iron",    "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("steel",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("coral",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("crystal",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("carnite",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("arkidine",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("energized",   "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("powered", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("force", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("gravity", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("nanite", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("void", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)
newArmor("null", "object/armor.png", colors.UMBER, 1, 20, 1, 1, 10, 1, 1)

-- Design for normal items by slot, with things like "full platemail" being a special collection of matched items
-- Armor slots: head, torso, arms, hands, legs, feet
-- Armor names: helmet, armor, bracers, gloves, greaves, boots
-- Armor construction, natural: natural, reinforced, ring
-- Armor construction, metal: chain, banded, plate
-- Armor construction, energy: ablative, reactive, continuous
-- Armor construction, mythical: <none>
