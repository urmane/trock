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
require "mod.class.Actor"
require "engine.interface.PlayerRest"
require "engine.interface.PlayerRun"
require "engine.interface.PlayerMouse"
require "engine.interface.PlayerHotkeys"
local Map = require "engine.Map"
local Dialog = require "engine.Dialog"
local ActorTalents = require "engine.interface.ActorTalents"
local DeathDialog = require "mod.dialogs.DeathDialog"
local Astar = require"engine.Astar"
local DirectPath = require"engine.DirectPath"

--- Defines the player
-- It is a normal actor, with some redefined methods to handle user interaction.<br/>
-- It is also able to run and rest and use hotkeys
module(..., package.seeall, class.inherit(
	mod.class.Actor,
	engine.interface.PlayerRest,
	engine.interface.PlayerRun,
	engine.interface.PlayerMouse,
	engine.interface.PlayerHotkeys
))

function _M:init(t, no_default)
	t.display=t.display or '@'
	t.color_r=t.color_r or 230
	t.color_g=t.color_g or 230
	t.color_b=t.color_b or 230

	t.player = true
	t.type = t.type or "humanoid"
	t.subtype = t.subtype or "player"
	t.faction = t.faction or "players"

	t.lite = t.lite or 0
    t.move_others = true -- used for bump-displacing

	mod.class.Actor.init(self, t, no_default)
	engine.interface.PlayerHotkeys.init(self, t)

	self.descriptor = {}
end

function _M:move(x, y, force)
	local moved = mod.class.Actor.move(self, x, y, force)
	if moved then
		game.level.map:moveViewSurround(self.x, self.y, 8, 8)
	end
	return moved
end

function _M:act()
	if not mod.class.Actor.act(self) then return end

    self:updateMainShader()

	-- Clean log flasher
	game.flash:empty()

	-- Resting ? Running ? Otherwise pause
	if not self:restStep() and not self:runStep() and self.player then
		game.paused = true
	end
end

function _M:playerPickup()
    -- If 2 or more objects, display a pickup dialog, otherwise just picks up
    if game.level.map:getObject(self.x, self.y, 2) then
        local d d = self:showPickupFloor("Pickup", nil, function(o, item)
            self:pickupFloor(item, true)
            self.changed = true
            d:used()
        end)
    else
        self:pickupFloor(1, true)
        self:sortInven()
        self:useEnergy()
    self.changed = true
    end
end

-- FIXME - why both playerDrop and doDrop ?
function _M:playerDrop()
    local inven = self:getInven(self.INVEN_INVEN)
    local d d = self:showInventory("Drop object", inven, nil, function(o, item)
        self:dropFloor(inven, item, true, true)
        self:sortInven(inven)
        self:useEnergy()
        self.changed = true
        return true
    end)
end
-- FIXME - why both playerDrop and doDrop ?
function _M:doDrop(inven, item, on_done, nb)
    if self.no_inventory_access then return end
    
    if nb == nil or nb >= self:getInven(inven)[item]:getNumber() then
        self:dropFloor(inven, item, true, true)
    else
        for i = 1, nb do self:dropFloor(inven, item, true) end
    end
    self:sortInven(inven)
    self:useEnergy()
    self.changed = true
    if on_done then on_done() end
end

function _M:doWear(inven, item, o)
    self:removeObject(inven, item, true)
    local ro = self:wearObject(o, true, true)
    if ro then
        if type(ro) == "table" then self:addObject(inven, ro) end
    elseif not ro then
        self:addObject(inven, o)
    end
    self:sortInven()
    self:useEnergy()
    self.changed = true
end

function _M:doTakeoff(inven, item, o)
    if self:takeoffObject(inven, item) then
        self:addObject(self.INVEN_INVEN, o)
    end
    self:sortInven()
    self:useEnergy()
    self.changed = true
end

function _M:playerUseItem(object, item, inven)
    local use_fct = function(o, inven, item)
        if not o then return end
        local co = coroutine.create(function()
            self.changed = true

            local used, ret = o:use(self, nil, inven, item)
            if not used then return end
            if ret and ret == "destroy" then
                if o.multicharge and o.multicharge > 1 then
                    o.multicharge = o.multicharge - 1
                else
                    local _, del = self:removeObject(self:getInven(inven), item)
                    if del then
                        game.log("I have no more %s.", o:getName{no_count=true, do_color=true})
                    else
                        game.log("I have %s.", o:getName{do_color=true})
                    end
                    self:sortInven(self:getInven(inven))
                end
                return true
            end

            self.changed = true
        end)
        local ok, ret = coroutine.resume(co)
        if not ok and ret then print(debug.traceback(co)) error(ret) end
        return true
    end

    if object and item then return use_fct(object, inven, item) end

    self:showEquipInven("Use object",
        function(o)
            return o:canUseObject()
        end,
        use_fct
    )
end

-- Precompute FOV form, for speed
local fovdist = {}
for i = 0, 30 * 30 do
	fovdist[i] = math.max((20 - math.sqrt(i)) / 14, 0.6)
end

function _M:playerFOV()
	-- Clean FOV before computing it
	game.level.map:cleanFOV()

	-- Compute both the normal and the lite FOV, using cache
	self:computeFOV(self.sight or 20, "block_sight",
        function(x, y, dx, dy, sqdist) game.level.map:apply(x, y, fovdist[sqdist]) end,
        true, false, true)
	self:computeFOV(self.lite, "block_sight",
        function(x, y, dx, dy, sqdist) game.level.map:applyLite(x, y) end,
        true, true, true)

	-- make other static and actor's lites visible
	-- from TOME module
    local uid, e = next(game.level.entities)
    while uid do
    	if e ~= self and e.lite and e.lite > 0 and e.computeFOV then
            if e.move_dir and e.lite_angle then
                -- If lite_angle is set, they have a non-circular lite
                -- Move_dir must also be set - if it's not, they have a circular lite but angled FOV
                e:computeFOVBeam(e.lite, e.move_dir, e.lite_angle, "block_sight",
                                 function(x, y, dx, dy, sqdist)
                                     game.level.map:applyExtraLite(x, y, fovdist[sqdist])
                                 end,
                                 true, true)
            else
                e:computeFOV(e.lite, "block_sight",
                             function(x, y, dx, dy, sqdist)
                                 game.level.map:applyExtraLite(x, y, fovdist[sqdist])
                             end,
                             true, true)
            end
        end
        uid, e = next(game.level.entities, uid)
    end

    -- ambient light is a level property, and lets you see a small number of grids around you if you're not holding a light.
    -- right now this is player-only - consider moving all sense code up to Actor
    -- in any case, only the player's ambient vision shows on the map
    if self.lite == 0 and game.level.data.ambient_light and game.level.data.ambient_light > 0 then
        -- assume ambient_light always < limit of sight for now
        local d = 0
        if self.nightvision then
            d = self.nightvision
        end
        self:computeFOV(game.level.data.ambient_light + d, "block_sight",
            function(x, y, dx, dy, sqdist) game.level.map:applyExtraLite(x, y) end,
            true, true, true)
    end
end

--- Called before taking a hit, overload mod.class.Actor:onTakeHit() to stop resting and running
function _M:onTakeHit(value, src)
	self:runStop("taken damage")
	self:restStop("taken damage")
	local ret = mod.class.Actor.onTakeHit(self, value, src)
	if self.life < self.max_life * 0.3 then
		local sx, sy = game.level.map:getTileToScreen(self.x, self.y)
		game.flyers:add(sx, sy, 30, (rng.range(0,2)-1) * 0.5, 2, "LOW HEALTH!", {255,0,0}, true)
	end
	return ret
end

function _M:die(src)
	if self.game_ender then
		engine.interface.ActorLife.die(self, src)
		game.paused = true
		self.energy.value = game.energy_to_act
		game:registerDialog(DeathDialog.new(self))
	else
		mod.class.Actor.die(self, src)
	end
end

function _M:setName(name)
	self.name = name
	game.save_name = name
end

--- Notify the player of available cooldowns
function _M:onTalentCooledDown(tid)
	local t = self:getTalentFromId(tid)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 30, -0.3, -3.5, ("%s available"):format(t.name:capitalize()), {0,255,00})
	game.log("#00ff00#Talent %s is ready to use.", t.name)
end

function _M:levelup()
	mod.class.Actor.levelup(self)

	local x, y = game.level.map:getTileToScreen(self.x, self.y)
	game.flyers:add(x, y, 80, 0.5, -2, "LEVEL UP!", {0,255,255})
	game.log("#00ffff#Welcome to level %d.", self.level)
end

--- Tries to get a target from the user
function _M:getTarget(typ)
	return game:targetGetForPlayer(typ)
end

--- Sets the current target
function _M:setTarget(target)
	return game:targetSetForPlayer(target)
end

local function spotHostiles(self)
	local seen = false
	-- Check for visible monsters, only see LOS actors, so telepathy wont prevent resting
	core.fov.calc_circle(self.x, self.y, game.level.map.w, game.level.map.h, 20, function(_, x, y) return game.level.map:opaque(x, y) end, function(_, x, y)
		local actor = game.level.map(x, y, game.level.map.ACTOR)
		if actor and self:reactionToward(actor) < 0 and self:canSee(actor) and game.level.map.seens(x, y) then seen = true end
	end, nil)
	return seen
end

--- Can we continue resting ?
-- We can rest if no hostiles are in sight, and if we need life/mana/stamina (and their regen rates allows them to fully regen)
function _M:restCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Check resources, make sure they CAN go up, otherwise we will never stop
	if self:getPower() < self:getMaxPower() and self.power_regen > 0 then return true end
	if self.life < self.max_life and self.life_regen> 0 then return true end

	return false, "all resources and life at maximum"
end

--- Can we continue running?
-- We can run if no hostiles are in sight, and if we no interesting terrains are next to us
function _M:runCheck()
	if spotHostiles(self) then return false, "hostile spotted" end

	-- Notice any noticeable terrain
	local noticed = false
	self:runScan(function(x, y)
		-- Only notice interesting terrains
		local grid = game.level.map(x, y, Map.TERRAIN)
		if grid and grid.notice then noticed = "interesting terrain" end
	end)
	if noticed then return false, noticed end

	self:playerFOV()

	return engine.interface.PlayerRun.runCheck(self)
end

--- Move with the mouse
-- We just feed our spotHostile to the interface mouseMove
function _M:mouseMove(tmx, tmy)
	return engine.interface.PlayerMouse.mouseMove(self, tmx, tmy, spotHostiles)
end

------ Quest Events
function _M:on_quest_grant(quest)
        game.logPlayer(game.player, "#LIGHT_GREEN#Accepted quest '%s'! #WHITE#(Press 'j' to see the quest log)", quest.name)
        game.bignews:say(60, "#LIGHT_GREEN#Accepted quest '%s'!", quest.name)
end

function _M:on_quest_status(quest, status, sub)
        if sub then
                game.logPlayer(game.player, "#LIGHT_GREEN#Quest '%s' status updated! #WHITE#(Press 'j' to see the quest log)", quest.name)
                game.bignews:say(60, "#LIGHT_GREEN#Quest '%s' updated!", quest.name)
        elseif status == engine.Quest.COMPLETED then
                game.logPlayer(game.player, "#LIGHT_GREEN#Quest '%s' completed! #WHITE#(Press 'j' to see the quest log)", quest.name)
                game.bignews:say(60, "#LIGHT_GREEN#Quest '%s' completed!", quest.name)
        elseif status == engine.Quest.DONE then
                game.logPlayer(game.player, "#LIGHT_GREEN#Quest '%s' is done! #WHITE#(Press 'j' to see the quest log)", quest.name)
                game.bignews:say(60, "#LIGHT_GREEN#Quest '%s' done!", quest.name)
        elseif status == engine.Quest.FAILED then
                game.logPlayer(game.player, "#LIGHT_RED#Quest '%s' is failed! #WHITE#(Press 'j' to see the quest log)", quest.name)
                game.bignews:say(60, "#LIGHT_RED#Quest '%s' failed!", quest.name)
        end
end

function _M:resetMainShader()
--    self.shader_old_life = nil
--    self.old_air = nil
--    self.old_psi = nil
--    self.old_healwarn = nil
    self:updateMainShader()
end

function _M:updateMainShader()
    if game.fbo_shader then
    end
end

-- testing only
-- "language" is just "font name" for starters/testing
-- at some point change it to map language to either foreign font or English (if known)
function _M:showForeignPopup(title, text, language)

    if title then print("title is ", title) else print("title is none") end
    if text then print("text is ", text) else print("text is none") end
    if language then print("language is ", language) else print("language is none") end

    local font = core.display.newFont("/data/font/"..language..".otf", 28)
    local w, h = font:size(text)
    local tw, th = font:size(title)
    local d = Dialog.new(title, math.max(w, tw) + 64, math.max(h, th) + 64, nil, nil, nil, font)
    d:keyCommands{__DEFAULT=function() game:unregisterDialog(d) if fct then fct() end end}
    d:mouseZones{{x=0, y=0, w=game.w, h=game.h, norestrict=true, fct=function(b) if b ~= "none" then game:unregisterDialog(d) end end, norestrict=true}}
    d.drawDialog = function(self, s)
        --s:drawColorStringCentered(self.font, text, 2, 2, self.iw - 2, self.ih - 2)
        s:drawColorStringCentered(self.font, text, 16, 8, self.iw - 32, self.ih - 8)
        self.changed = false
    end
    game:registerDialog(d)
    return d
end
