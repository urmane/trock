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

-- ITS AIs
-- These AI are modified from engine base:
--    does not assume enemies are seen, see Actor:canSee()
--    ITS allows initially moving items - guards follow psuedo-"routes" for instance
--    multiple senses, tested in universal order: if self.ai_sees, ai_hears, ai_smells, ai_feels, ai_tastes
--        primary is the first true in that list, secondary is any other
--    detection not based on senses: ai_knows?
-- Currently restricted to ActorFOV, which is based on vision, alas
-- Base AI are either dormant or targeting, ITS adds a suspicious and normal pattern-based movement
--
--[[
   ai_sees = false
   ai_hears = false
   ai_smells = false
   ai_feels = false
   ai_tastes = false
   ai_knows = false
   ai_focus = int -- rng.percent(self.ai_focus) that self sticks to target normally
   ai_morale = int -- if ((self.hp / self.total_hp) * 100.0) < self.ai_morale then self:runAI("run_away")
   global_speed = float -- actual speed
   pursuit_speed = float -- target acquired with primary sense
   suspicious_speed = float -- target detected with secondary sense
--]]

newAI("none", function(self)
    return true
end)

-- Find an hostile target
-- this requires the ActorFOV interface, or an interface that provides self.fov.actors*
-- modified from TOME original
newAI("its_target_simple", function(self)
    if self.ai_target.actor and not self.ai_target.actor.dead and rng.percent(90) then return true end

    -- Find closer enemy and target it
    -- Get list of actors ordered by distance
    local arr = self.fov.actors_dist
    local act
    for i = 1, #arr do
        act = self.fov.actors_dist[i]
--      print("AI looking for target", self.uid, self.name, "::", act.uid, act.name, self.fov.actors[act].sqdist)
        -- find the closest enemy
        if act and self:canSee(act,true,100) and self:reactionToward(act) < 0 and not act.dead then
            self:setTarget(act)
            self:check("on_acquire_target", act)
            if self.pursuit_speed then
                self.global_speed = self.pursuit_speed
            end
            return true
        end
    end
end)

-- If no target, move in previous direction until we hit an obstacle, then turn in a random direction
-- may want to modify move_simple/last_seen  to search - the guard is aware
newAI("its_guard_wander", function(self)
	if self:runAI(self.ai_state.ai_target or "its_target_simple") then
		return self:runAI(self.ai_state.ai_move or "move_simple")
	else
		local counter = 0
		local number_attempts = 4
		local x, y = util.dirToCoord(self.move_dir)
		while ( counter < 4 ) and not self:canMove(self.x + x, self.y + y) do
			if not self:canMove(self.x + x, self.y + y) then
				counter = counter + 1
				local dir = rng.range(1, 3)
				if     (dir == 1) then self.move_dir = util.dirSides(self.move_dir)["hard_left"]
				elseif (dir == 2) then self.move_dir = util.dirSides(self.move_dir)["hard_right"]
				else                   self.move_dir = util.opposedDir(self.move_dir) end 
				x, y = util.dirToCoord(self.move_dir)
			end
		end
		if (counter >= 4) then
			return self:runAI("move_wander")
		else
			return self:moveDir(self.move_dir)
		end
	end
end)

newAI("stationary_emoter", function(self)
        if self:canSee(game.player) and self:hasLOS(game.player.x,game.player.y,nil,nil,self.x,self.y) then
        	return self:setRandomEmote()
        end
end)

newAI("prisoner", function(self)
	if self:canSee(game.player) and self:hasLOS(game.player.x,game.player.y,nil,nil,self.x,self.y) then
        return self:setRandomEmote()
		--return self:setEmote(require("engine/Emote").new("Help me ...", 60, colors.GREY))
		-- return self:setEmote(require("engine/Emote").new(rng.table{
  --           "Help me ...", "Please ...", "Good sir!", "Hey!", "Guards!!", "How'd you get out?!",
  --           "Guards! Guards!", "Get me out!", "You there!"},
  --           30, colors.DARK_GREY))
	end
end)

-- Pinball, similar to guard wander above - move until blocked
newAI("pinball", function(self)
    if not self.move_dir then
        self.move_dir = 1
    end
    local counter = 0
    local number_attempts = 4
    local x, y = util.dirToCoord(self.move_dir)
    while ( counter < 4 ) and not self:canMove(self.x + x, self.y + y) do
        if not self:canMove(self.x + x, self.y + y) then
            counter = counter + 1
            local dir = rng.range(1, 3)
            if     (dir == 1) then self.move_dir = util.dirSides(self.move_dir)["hard_left"]
            elseif (dir == 2) then self.move_dir = util.dirSides(self.move_dir)["hard_right"]
            else                   self.move_dir = util.opposedDir(self.move_dir) end
            x, y = util.dirToCoord(self.move_dir)
        end
    end
    if (counter >= 4) then
        return self:runAI("move_wander")
    else
        return self:moveDir(self.move_dir)
    end
end)

newAI("townperson", function(self)
    self:runAI("pinball")
	if self:canSee(game.player) and self:hasLOS(game.player.x,game.player.y,nil,nil,self.x,self.y) then
        return self:setRandomEmote("townperson")
	end
end)

newAI("pinball_emoter", function(self)
    self:runAI("pinball")
    if self:canSee(game.player) and self:hasLOS(game.player.x,game.player.y,nil,nil,self.x,self.y) then
        return self:setRandomEmote("townperson")
    end
end)
