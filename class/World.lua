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
require "engine.World"
require "engine.interface.WorldAchievements"
local Savefile = require "engine.Savefile"

module(..., package.seeall, class.inherit(engine.World, engine.interface.WorldAchievements))

function _M:init()
    engine.World.init(self)
end

function _M:run()
    self:loadAchievements()
end

--- Requests the world to save
function _M:saveWorld(no_dialog)
    -- savefile_pipe is created as a global by the engine
    savefile_pipe:push("", "world", self)
end

--- Format an achievement source
-- @param src the actor who did it
function _M:achievementWho(src)
    --local p = game.party:findMember{main=true}
    --return p.name.." the "..p.descriptor.subrace.." "..p.descriptor.subclass.." level "..p.level
    local p = game.player
    return p.name.." level "..p.level
end

--- Gain an achievement
-- @param id the achievement to gain
-- @param src who did it
function _M:gainAchievement(id, src, ...)
    local no_difficulties = false
    if type(id) == "table" then
        no_difficulties = id.no_difficulties
        id = id.id
    end

    local a = self.achiev_defs[id]
    if not a then return end
    local knew = self.achieved[id]
    engine.interface.WorldAchievements.gainAchievement(self, id, src, ...)
    --if not knew and self.achieved[id] then game.party.on_death_show_achieved[#game.party.on_death_show_achieved+1] = "Gained new achievement: "..a.name end
end


