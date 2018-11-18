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

require "engine.class"
require "engine.Grid"
local DamageType = require "engine.DamageType"
local Dialog = require "engine.ui.Dialog"

module(..., package.seeall, class.inherit(engine.Grid))

function _M:init(t, no_default)
	engine.Grid.init(self, t, no_default)
end

function _M:block_move(x, y, e, act, couldpass)
	-- Locked doors
	if self.door_unlocked then
		return true
	end

	-- Open doors
	if self.door_opened and act then
		game.level.map(x, y, engine.Map.TERRAIN, game.zone.grid_list.DOOR_OPEN)
		return true
	elseif self.door_opened and not couldpass then
		return true
	end

	-- Pass walls
	if e and self.can_pass and e.can_pass then
		for what, check in pairs(e.can_pass) do
			if self.can_pass[what] and self.can_pass[what] <= check then return false end
		end
	end

    -- Check for bump effects
    -- on_block_bump is a function defined on the entity
    -- on_block_bump_msg is an attr defined on the grid (for uniques) and on the entity (for generics)
    if e and act and self.does_block_move and e.player and self.on_block_bump then
        self.on_block_bump(e)
        -- do the general one first
        if self.on_block_bump_msg then
        	game.log("%s", self.on_block_bump_msg)
        end
        -- if there's a unique do that, too
        if game.level.map.attrs(x, y, "on_block_bump_msg") then
        	game.log("%s", game.level.map.attrs(x, y, "on_block_bump_msg"))
        end
    end

    -- Check for block changes
    if e and act and self.does_block_move and e.player and game.level.map.attrs(x, y, "on_block_change") then
        local ng = game.zone:makeEntityByName(game.level, "terrain", game.level.map.attrs(x, y, "on_block_change"))
        if ng then
            if game.level.map.attrs(x, y, "on_block_change_msg") then
				--game.logSeen({x=x, y=y}, "%s", game.level.map.attrs(x, y, "on_block_bump_msg"))
				game.log("%s", game.level.map.attrs(x, y, "on_block_change_msg"))
	    	end
            game.zone:addEntity(game.level, ng, "terrain", x, y)
            game.level.map.attrs(x, y, "on_block_change", false)
            game.level.map.attrs(x, y, "on_block_change_msg", false)
        end
    end

	return self.does_block_move
end

function _M:on_move(x, y, who, forced)
	if forced then return end
	if who.move_project and next(who.move_project) then
		for typ, dam in pairs(who.move_project) do
			DamageType:get(typ).projector(who, x, y, typ, dam)
		end
	end
end
function _M:tooltip()
	if self.show_tooltip then
		local name = ((self.show_tooltip == true) and self.name or self.show_tooltip)
		if self.desc then
			return self:getDisplayString()..name.."\n"..self.desc
		else
			return self:getDisplayString()..name
		end
	else
		return self:getDisplayString()..self.name
	end
end
