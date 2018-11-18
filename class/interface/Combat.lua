-- ToME - Tales of Middle-Earth
-- Copyright (C) 2009, 2010, 2011, 2012 Nicolas Casalini
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
-- Nicolas Casalini "DarkGod"
-- darkgod@te4.org

require "engine.class"
local DamageType = require "engine.DamageType"
local Map = require "engine.Map"
local Chat = require "engine.Chat"
local Target = require "engine.Target"
local Talents = require "engine.interface.ActorTalents"

--- Interface to add ToME combat system
module(..., package.seeall, class.make)

--- Checks what to do with the target
-- Talk ? attack ? displace ?
function _M:bumpInto(target)
	local reaction = self:reactionToward(target)
--    print("[DBG]name "..self.name.." reactionToward "..target.name.." is "..reaction)
	if reaction < 0 then
		return self:attackTarget(target)
	elseif reaction >= 0 then
		if self.player and target.on_bump then
			-- Bump
            target:on_bump(self)
        elseif self.player and target.can_talk then
			-- Talk
            local chat = Chat.new(target.can_talk, target, self, {npc=target, player=self})
            chat:invoke()
            if target.can_talk_only_once then target.can_talk = nil end
        elseif target.player and self.can_talk then
			-- Talk
            local chat = Chat.new(self.can_talk, self, target, {npc=self, player=target})
            chat:invoke()
            if target.can_talk_only_once then target.can_talk = nil end
		elseif self.move_others and not target.cant_be_moved then
			-- Displace
			game.level.map:remove(self.x, self.y, Map.ACTOR)
			game.level.map:remove(target.x, target.y, Map.ACTOR)
			game.level.map(self.x, self.y, Map.ACTOR, target)
			game.level.map(target.x, target.y, Map.ACTOR, self)
			self.x, self.y, target.x, target.y = target.x, target.y, self.x, self.y
		end
	end
end

--- Makes the death happen!
function _M:attackTarget(target, mult)
	if self.combat then
		local dam = self.combat.dam + self:getStr() - target.combat_armor
		DamageType:get(DamageType.PHYSICAL).projector(self, target.x, target.y, DamageType.PHYSICAL, math.max(0, dam))
	end

	-- We use up our own energy
	self:useEnergy(game.energy_to_act)
end
