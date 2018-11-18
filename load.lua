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

-- Init settings
dofile("/mod/settings.lua")

-- This file loads the game module, and loads data
local KeyBind = require "engine.KeyBind"
local DamageType = require "engine.DamageType"
local ActorStats = require "engine.interface.ActorStats"
local ActorResource = require "engine.interface.ActorResource"
local ActorTalents = require "engine.interface.ActorTalents"
local ActorAI = require "engine.interface.ActorAI"
local ActorInventory = require "engine.interface.ActorInventory"
local ActorLevel = require "engine.interface.ActorLevel"
local ActorTemporaryEffects = require "engine.interface.ActorTemporaryEffects"
local Birther = require "engine.Birther"
local Store = require "mod.class.Store"
local WorldAchievements = require "engine.interface.WorldAchievements"
local Faction = require "engine.Faction"

-- Achievements
WorldAchievements:loadDefinition("/data/achievements/")

-- Useful keybinds
KeyBind:load("move,hotkeys,inventory,actions,interface,debug")

-- Politics
-- explicit "neutral"
-- explicit "animal"
-- explicit "all" reaction, change code to match
Faction:add{ name="Operation Entertainment", reaction={players=-100} }
Faction:add{ name="The Guild", reaction={players=-10} }
Faction:add{ name="Secret Brotherhood", reaction={} }
Faction:add{ name="Order Of The Sword", reaction={} }
--Faction:add{ name="neutral", reaction={players=0} }
Faction:add{ name="animal", reaction={} }
Faction:setInitialReaction("players", "neutral", 0, true)
Faction:setInitialReaction("players", "animal", -1, true)

-- Damage types
DamageType:loadDefinition("/data/damage_types.lua")

-- Talents
ActorTalents:loadDefinition("/data/talents.lua")

-- Timed Effects
ActorTemporaryEffects:loadDefinition("/data/timed_effects.lua")

-- Actor resources
-- Arrange these in order of importance/variability - reputation on top
ActorResource:defineResource("Reputation", "reputation", nil, "power_regen", "The Fame Monster that eats us all ...")
ActorResource:defineResource("Power", "power", nil, "power_regen", "Power represent your ability to use special talents.")
ActorResource:defineResource("Gold", "gold", nil, nil, "Total liquid assets portion of total net worth.")
ActorResource:defineResource("breath", "breath", nil, "power_regen", "Holding your breath, like under water.")
ActorResource:defineResource("Earth", "earth", nil, "power_regen", "Earth mana.")
ActorResource:defineResource("Air",   "air",   nil, "power_regen", "Air mana.")
ActorResource:defineResource("Fire",  "fire", nil, "power_regen", "Fire mana.")
ActorResource:defineResource("Water", "water", nil, "power_regen", "Water mana.")

-- Actor stats
-- Body
ActorStats:defineStat("Strength",	"str", 10, 1, 100, "Strength defines your character's physical strength. It increases your carrying capacity.")
ActorStats:defineStat("Dexterity",	"dex", 10, 1, 100, "Dexterity defines your character's agility and alertness.  It increases your ...")
ActorStats:defineStat("Senses",  	"sns", 10, 1, 100, "Senses defines how good your perception of your environment is.  It increases your ...")
-- Mind
ActorStats:defineStat("Cognitive",	"cog", 10, 1, 100, "Mental acuity, general knowledge, and deduction.  It increases your ...")
ActorStats:defineStat("Reaction",	"rct", 10, 1, 100, "Reaction defines how fast you can react.  It increases your ...")
ActorStats:defineStat("Charisma",	"chr", 10, 1, 100, "Personal magnetism.  It increases your ...")
-- Spirit
ActorStats:defineStat("Will",		"wil", 10, 1, 100, "How much willpower you have.  It increases your ...")
ActorStats:defineStat("Attunement",	"att", 10, 1, 100, "How attuned you are to your surroundings.  It increases your ...")
ActorStats:defineStat("Luck",		"lck", 10, 1, 100, "How lucky you are.  It increases your ...")

-- Actor AIs
ActorAI:loadDefinition("/engine/ai/")
ActorAI:loadDefinition("/mod/ai/")

-- custom resolvers
dofile("/mod/resolvers.lua")

-- Equipment slots
-- armor-ish
ActorInventory:defineInventory("HEAD", "protecting my head", true, "Head")
ActorInventory:defineInventory("TORSO", "covering my body", true, "Body")
ActorInventory:defineInventory("ARMS", "covering my arms", true, "Arms")
ActorInventory:defineInventory("HANDS", "worn on my hands", true, "Hands")
ActorInventory:defineInventory("LEGS", "covering my legs", true, "Legs")
ActorInventory:defineInventory("FEET", "on my feet", true, "Feet")
-- tools
ActorInventory:defineInventory("WEAPON", "in my weapon hand", true, "Main hand")
ActorInventory:defineInventory("OFFHAND", "in my off hand", true, "Off hand")
-- equips
ActorInventory:defineInventory("CLOAK", "draped over my shoulders", true, "Cloak")
ActorInventory:defineInventory("BELT", "around my waist", true, "Belt")
ActorInventory:defineInventory("QUIVER", "holding my arrows", true, "Quiver")
ActorInventory:defineInventory("PACK", "holding my stuff", true, "Pack")
-- jewelry, etc
ActorInventory:defineInventory("HOVER", "circling my head", true, "Orbital")
ActorInventory:defineInventory("NECK", "around my neck", true, "Neck")
ActorInventory:defineInventory("RING1", "on my ring finger", true, "First ring")
ActorInventory:defineInventory("RING2", "on my ring finger", true, "Second ring")
-- Thoughts for later
--ActorInventory:defineInventory("LITE", "my light source", true, "Light")
--ActorInventory:defineInventory("WATERSKIN", "my liquid refreshment", true, "Waterskin")
--ActorInventory:defineInventory("TOOL", "my ready tool", true, "Tool")
--ActorInventory:defineInventory("AURA", "my aura", true, "Aura")
--ActorInventory:defineInventory("Pouch", "my ready pouch", true, "Pouch")

-- Birther descriptor
Birther:loadDefinition("/data/birth/descriptors.lua")

-- Stores
Store:loadStores("/data/general/stores/basic.lua")

-- Uncomment this for hex mode
-- core.fov.set_algorithm("hex")

return {require "mod.class.Game", require "mod.class.World"}
