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

local tacticals = {}
local Entity = require "engine.Entity"

local oldNewTalent = Talents.newTalent
Talents.newTalent = function(self, t)
    assert(engine.interface.ActorTalents.talents_types_def[t.type[1]], "No talent category "..tostring(t.type[1]).." for talent "..t.name)
    if engine.interface.ActorTalents.talents_types_def[t.type[1]].generic then t.generic = true end
    -- examples from TOME
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].no_silence then t.no_silence = true end
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].is_spell then t.is_spell = true end
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].is_mind then t.is_mind = true end
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].is_nature then t.is_nature = true end
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].is_unarmed then t.is_unarmed = true end
    -- if engine.interface.ActorTalents.talents_types_def[t.type[1]].autolearn_mindslayer then t.autolearn_mindslayer = true end

    -- not sure what this is
    if t.tactical then
        local tacts = {}
        for tact, val in pairs(t.tactical) do
            tact = tact:lower()
            tacts[tact] = val
            tacticals[tact] = true
        end
        t.tactical = tacts
    end

    -- find image name from talent name
    if not t.image then
        t.image = "talents/"..(t.short_name or t.name):lower():gsub("[^a-z0-9_]", "_")..".png"
    end
    if fs.exists("/data/gfx/"..t.image) then t.display_entity = Entity.new{image=t.image, is_talent=true}
    else t.display_entity = Entity.new{image="talents/default.png", is_talent=true}
    end
    return oldNewTalent(self, t)
end

-- Not sure I need this, it's from TOME
damDesc = function(self, type, dam)
    -- Increases damage
    if self.inc_damage then
        local inc = self:combatGetDamageIncrease(type)
        dam = dam + (dam * inc / 100)
    end
    return dam
end

Talents.damDesc = damDesc
Talents.main_env = getfenv(1)

load("/data/talents/advanced-mechanic.lua")
load("/data/talents/awareness.lua")
load("/data/talents/control.lua")
load("/data/talents/death.lua")
load("/data/talents/mechanic.lua")
load("/data/talents/politics.lua")
load("/data/talents/shadow.lua")
load("/data/talents/speed.lua")
load("/data/talents/stealth.lua")
load("/data/talents/thief.lua")
load("/data/talents/unarmed.lua")

print("[TALENTS TACTICS]")
for k, _ in pairs(tacticals) do print(" * ", k) end
