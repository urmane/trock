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

-- The basic stuff used to damage a grid
setDefaultProjector(function(src, x, y, type, dam)
	-- Note that this currently directly impacts actor's HP and such
	-- Add the ability for some types to impact other things, eg:
	-- concusive can shatter potions or mirrors, held or on the floor
	-- radiation could impact energy weapons/armor
	-- fire can burn lots of things, from hide armor to scrolls to potions to melting gold ... mwahahahaha
	local target = game.level.map(x, y, Map.ACTOR)
	if target then
		local flash = game.flash.NEUTRAL
		if target == game.player then
			game.logSeen(target,
				game.flash.BAD, "%s hits me for %s%0.2f %s damage#LAST#.",
				src.name:capitalize(),
				DamageType:get(type).text_color or "#aaaaaa#",
				dam,
				DamageType:get(type).name)
		 end
		if src == game.player then
			game.logSeen(target,
				game.flash.GOOD,
				"I hit %s for %s%0.2f %s damage#LAST#.",
				target.name,
				DamageType:get(type).text_color or "#aaaaaa#",
				dam,
				DamageType:get(type).name)
		end

		local sx, sy = game.level.map:getTileToScreen(x, y)
		if target:takeHit(dam, src) then
			if src == game.player or target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, "Kill!", {255,0,255})
			end
		else
			if src == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {0,255,0})
			elseif target == game.player then
				game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, -3, tostring(-math.ceil(dam)), {255,0,0})
			end
		end
		return dam
	end
	return 0
end)

newDamageType{
	name = "cosmetic", type="COSMETIC",
	projector = function(src, x, y, type, dam)
	end,
	death_message = {"cosmeticized"} -- is this TOME-only, or base engine?
}

newDamageType{
	name = "physical", type = "PHYSICAL", text_color = "#WHITE#",
}

-- Elemental damage
newDamageType{
	name = "fire", type = "FIRE", text_color = "#RED#",
	death_message = {"fricasseed"}
}

newDamageType{
	name = "cold", type = "COLD", text_color = "#BLUE#",
	death_message = {"frozen"}
}

-- concussive
newDamageType{
	name = "earth", type = "EARTH", text_color = "#BROWN#",
	death_message = {"entombed"}
}

-- blinds, disorients, suffocates
newDamageType{
	name = "air", type = "AIR", text_color = "#YELLOW#",
	death_message = {"blown apart"}
}

-- Fire and earth, burning and sticking, euw
newDamageType{
	name = "lava", type = "LAVA", text_color = "#RED#",
	death_message = {"charred"}
}

-- Fire and water 
-- steam lingers, drifts, and burns
newDamageType{
	name = "steam", type = "STEAM", text_color = "#YELLOW#",
	death_message = {"scalded"}
}

-- Fire and air
-- Heat is similar to fire but can melt things, too
newDamageType{
	name = "heat", type = "HEAT", text_color = "#YELLOW#",
	death_message = {"baked"}
}

-- Water and earth
-- Mud slows, concusses, slowly suffocates
newDamageType{
	name = "mud", type = "MUD", text_color = "#BROWN#",
	death_message = {"suffocated"}
}

-- Water and air
-- Mist obscures vision and quickly drowns
newDamageType{
	name = "mist", type = "MIST", text_color = "#GREEN#",
	death_message = {"drowned"}
}

-- Earth and air
newDamageType{
	name = "poisongas", type = "POISONGAS", text_color = "#GREEN#",
	death_message = {"choked"}
}

-- Miscellaneous physical

-- Acid destroys things
newDamageType{
	name = "acid", type = "ACID", text_color = "#GREEN#",
	death_message = {"dissolved"}
}

-- biological mechanism of action:
-- inhibition, activation, agonism, antagonism
newDamageType{
	name = "poison", type = "POISON", text_color = "#RED#",
	death_message = {"poisoned"}
}

newDamageType{
	name = "disease", type = "DISEASE", text_color = "#RED#",
	death_message = {"diseased"}
}

-- sharp
newDamageType{
	name = "lacerative", type = "LACERATIVE", text_color = "#RED#",
	death_message = {"sliced"}
}

-- blunt
newDamageType{
	name = "concussive", type = "CONCUSSIVE", text_color = "#RED#",
	death_message = {"traumatized"}
}

newDamageType{
	name = "auditory", type = "AUDITORY", text_color = "#WHITE#",
	death_message = {"deafened"}
}

newDamageType{
	name = "radiation", type = "RADIATION", text_color = "#PURPLE#",
	death_message = {"exposed"}
}

-- Mental
newDamageType{
	name = "neurological", type = "NEUROLOGICAL", text_color = "#PURPLE#",
	death_message = {"tripped"}
}
newDamageType{
	name = "hallucinatory", type = "HALLUCINATORY", text_color = "#PURPLE#",
	death_message = {"tripped"}
}

-- Spiritual
newDamageType{
	name = "luck", type = "LUCK", text_color = "#PURPLE#",
	death_message = {"Murphied"}
}
newDamageType{
	name = "divine", type = "DIVINE", text_color = "#PURPLE#",
	death_message = {"divined"}
}

-- Magical?
-- does magic damage directly, or just cause other types of damage?
-- Curses!
