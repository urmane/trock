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

local Stats = require "engine.interface.ActorStats"

newEffect{
	name = "ACIDBURN",
	desc = "Burning from acid",
	type = "physical",
	status = "detrimental",
	parameters = { power=1 },
	on_gain = function(self, err) return "#Target# is covered in acid!", "+Acid" end,
	on_lose = function(self, err) return "#Target# is free from the acid.", "-Acid" end,
	on_timeout = function(self, eff)
		DamageType:get(DamageType.ACID).projector(eff.src or self, self.x, self.y, DamageType.ACID, eff.power)
	end,
}

newEffect{
	name = "MAGICPUTTY",
	image = "talents/acidic_skin.png",
	desc = "Not entirely clear",
	long_desc = function(self, eff)
		return ("Scoured by natural acid, reducing their offensive power ratings by %d%%."):format(eff.pct*100 or 0)
		end,
	type = "magical",
	subtype = { acid=true },
	status = "detrimental",
	parameters = { power=1 },
	charges = function(self, eff) return eff.stacks end,
	on_gain = function(self, err) return "#Target# is covered in magic putty!", "+Acid" end,
	on_lose = function(self, err) return "#Target# is free from the magic putty.", "-Acid" end,
	on_timeout = function(self, eff)
		DamageType:get(DamageType.ACID).projector(eff.src or self, self.x, self.y, DamageType.ACID, eff.power)
	end,
	activate = function(self, eff)
        self:effectTemporaryValue(eff, "scoured", 1)
    end,
    deactivate = function(self, eff)

    end,
}

newEffect{
	name = "WEAKDISEASE",
	image = "talents/acidic_skin.png",
	desc = "Weakening disease",
	long_desc = function(self, eff)
		return ("Diease that saps strenght by %d%%."):format(eff.pct*100 or 0)
		end,
	type = "physical",
	subtype = { disease=true },
	status = "detrimental",
	parameters = { power=1 },
	charges = function(self, eff) return eff.stacks end,
	on_gain = function(self, err) return "#Target# is suffering from a weakening disease!", "+Weakdisease" end,
	on_lose = function(self, err) return "#Target# is free of the weakening disease.", "-Weakdisease" end,
	on_timeout = function(self, eff)
		DamageType:get(DamageType.ACID).projector(eff.src or self, self.x, self.y, DamageType.ACID, eff.power)
	end,
	activate = function(self, eff)
        self:effectTemporaryValue(eff, "scoured", 1)
    end,
    deactivate = function(self, eff)

    end,
}
