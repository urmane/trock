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
require "engine.GameTurnBased"
require "engine.interface.GameMusic"
require "engine.interface.GameSound"
require "engine.interface.GameTargeting"
require "engine.KeyBind"
local Savefile = require "engine.Savefile"
local DamageType = require "engine.DamageType"
local Zone = require "engine.Zone"
local Map = require "engine.Map"
local Level = require "engine.Level"
local Birther = require "engine.Birther"
local Shader = require "engine.Shader"

local Grid = require "mod.class.Grid"
local Actor = require "mod.class.Actor"
local Player = require "mod.class.Player"
local NPC = require "mod.class.NPC"

local PlayerDisplay = require "mod.class.PlayerDisplay"
local HotkeysDisplay = require "engine.HotkeysIconsDisplay"
local ActorsSeenDisplay = require "engine.ActorsSeenDisplay"
local LogDisplay = require "engine.LogDisplay"
local LogFlasher = require "engine.LogFlasher"
local DebugConsole = require "engine.DebugConsole"
local FlyingText = require "engine.FlyingText"
local Tooltip = require "engine.Tooltip"
local BigNews = require "mod.class.BigNews"
local Calendar = require "mod.class.Calendar"
local GameState = require "mod.class.GameState"
local Store = require "mod.class.Store"

local QuitDialog = require "mod.dialogs.Quit"

local Markov = require "mod.class.Markov"

module(..., package.seeall, class.inherit(engine.GameTurnBased, engine.interface.GameMusic, engine.interface.GameSound, engine.interface.GameTargeting))

-- Tell the engine that we have a fullscreen shader that supports gamma correction
support_shader_gamma = true

function _M:init()
	engine.GameTurnBased.init(self, engine.KeyBind.new(), 1000, 100)
    engine.interface.GameMusic.init(self)
    engine.interface.GameSound.init(self)

	-- Pause at birth
	self.paused = true

	-- Same init as when loaded from a savefile
	self:loaded()
end

function _M:run()
    self.calendar = Calendar.new("/data/calendar.lua", "Today is the %s %s of the %s year of the Age of NoAge.\nThe time is %02d:%02d.", 1, 1, 1)
	self.flash = LogFlasher.new(208, 0, self.w, 20, nil, nil, nil, {255,255,255}, {0,0,0})
	self.player_display = PlayerDisplay.new(0, 0, 200, self.h, {30,30,0}, "/data/font/VeraMono.ttf", 12)
	self.logdisplay = LogDisplay.new(0, self.h * 0.8, self.w * 0.5, self.h * 0.2, nil, nil, nil, {255,255,255}, {30,30,30})
	self.hotkeys_display = HotkeysDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,0}, nil, nil, 64, 64)
	self.npcs_display = ActorsSeenDisplay.new(nil, self.w * 0.5, self.h * 0.8, self.w * 0.5, self.h * 0.2, {30,30,0})
	self.tooltip = Tooltip.new(nil, nil, {255,255,255}, {30,30,30})
	self.flyers = FlyingText.new("/data/font/DroidSans.ttf",14,"/data/font/DroidSans.ttf",18)
	self:setFlyingText(self.flyers)
	self.bignews = BigNews.new("/data/font/DroidSansMono.ttf", 30)
	self.flyers:enableShadow(0.6)

	self.log = function(style, ...) if type(style) == "number" then self.logdisplay(...) self.flash(style, ...) else self.logdisplay(style, ...) self.flash(self.flash.NEUTRAL, style, ...) end end
	self.logSeen = function(e, style, ...) if e and self.level.map.seens(e.x, e.y) then self.log(style, ...) end end
	self.logPlayer = function(e, style, ...) if e == self.player then self.log(style, ...) end end

	self.log(self.flash.GOOD, "Welcome to #00FF00#ITS!")

	-- Setup inputs
	self:setupCommands()
	self:setupMouse()

	-- Starting from here we create a new game
	if not self.player then self:newGame() end

	self.hotkeys_display.actor = self.player
	self.npcs_display.actor = self.player

	-- Setup the targetting system
	engine.interface.GameTargeting.init(self)

	-- Things to do at tick end
	-- Run music
	self:onTickEnd(function()
		print("[DBG]ontick end, playing music")
		self:playMusic()
	end)

	-- Ok everything is good to go, activate the game in the engine!
	self:setCurrent()

	if self.level then self:setupDisplayMode() end
end

function _M:newGame()
	self.player = Player.new{name=self.player_name, game_ender=true}
	Map:setViewerActor(self.player)
	self:setupDisplayMode()

	--FIXME remove this at some point
	self.markov = {}
	self.markov["dwarvish"]= {}
	self.markov["dwarvish"]= Markov:new()
	self.markov["dwarvish"]:loadChain("/data/markov/dwarvish.lua")
	self.markov["elvish"]= {}
	self.markov["elvish"]= Markov:new()
	self.markov["elvish"]:loadChain("/data/markov/elvish.lua")
	self.markov["english"]= {}
	self.markov["english"]= Markov:new()
	self.markov["english"]:loadChain("/data/markov/englishProper.lua")
	local testname = self.markov["elvish"]:generateWord("L", 3, 9)
	print("new elvish markov word is ", testname)
	testname = self.markov["dwarvish"]:generateWord("K", 5, 10)
	print("new dwarvish markov word is ", testname)
	testname = self.markov["english"]:generateWord("M", 5, 12)
	print("new english markov word is ", testname)

    self.state = GameState.new()
	self.creating_player = true
	local birth = Birther.new(nil, self.player, {"base", "role" }, function()
		if config.settings.cheat then
			self:changeLevel(1, config.settings.its.cheat_start_zone)
		else
			-- For real game start:
			self:changeLevel(1, "gora-prison")
		end
		print("[PLAYER BIRTH] resolve...")
		self.player:resolve()
		self.player:resolve(nil, true)
		self.player.energy.value = self.energy_to_act
		self.paused = true
		self.creating_player = false
		print("[PLAYER BIRTH] resolved!")
                local d = require("engine.dialogs.ShowText").new("Welcome to ITS", "introduction", {name=self.player.name}, nil, nil, function()
			-- This code is from TOME, dunno what it all does yet
                        -- For quickbirth
                        -- savefile_pipe:push(self.player.name, "entity", self.party, "engine.CharacterVaultSave")
                        -- self.creating_player = false
                        -- self.player:grantQuest(self.player.starting_quest)
                        self.player:grantQuest("start")
                        -- birth_done()
                        -- self.player:check("on_birth_done")
                        -- if __module_extra_info.birth_done_script then loadstring(__module_extra_info.birth_done_script)() end
                end, true)
                self:registerDialog(d)

	end)
	self:registerDialog(birth)
end

function _M:loaded()
	engine.GameTurnBased.loaded(self)
	engine.interface.GameMusic.loaded(self)
    engine.interface.GameSound.loaded(self)
	Zone:setup{npc_class="mod.class.NPC", grid_class="mod.class.Grid", object_class="mod.class.Object"}
	Map:setViewerActor(self.player)
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 48, 48, nil, 22, true)
	self.key = engine.KeyBind.new()
end

function _M:setupDisplayMode()
	print("[DISPLAY MODE] 48x48 ASCII/background")
	Map:setViewPort(200, 20, self.w - 200, math.floor(self.h * 0.80) - 20, 48, 48, nil, 22, true)
	Map:resetTiles()
	Map.tiles.use_images = true

	if self.level then
		self.level.map:recreate()
		engine.interface.GameTargeting.init(self)
		self.level.map:moveViewSurround(self.player.x, self.player.y, 8, 8)
	end
    self:createFBOs()
end

function _M:createFBOs()
    print("[GAME] Creating FBOs")

    -- Create the framebuffer
    self.fbo = core.display.newFBO(Map.viewport.width, Map.viewport.height)
    if self.fbo then
        self.fbo_shader = Shader.new("main_fbo")
        self.posteffects = {
            wobbling = Shader.new("main_fbo/wobbling"),
            underwater = Shader.new("main_fbo/underwater"),
            motionblur = Shader.new("main_fbo/motionblur"),
            blur = Shader.new("main_fbo/blur"),
        }
        self.posteffects_use = { self.fbo_shader.shad }
        if not self.fbo_shader.shad then self.fbo = nil self.fbo_shader = nil end 
        self.fbo2 = core.display.newFBO(Map.viewport.width, Map.viewport.height)
    end
    
    if self.player then self.player:updateMainShader() end

    self.full_fbo = core.display.newFBO(self.w, self.h)
    if self.full_fbo then self.full_fbo_shader = Shader.new("full_fbo") if not self.full_fbo_shader.shad then self.full_fbo = nil self.full_fbo_shader = nil end end

    if self.fbo and self.fbo2 then core.particles.defineFramebuffer(self.fbo)
    else core.particles.defineFramebuffer(nil) end

    if self.target then self.target:enableFBORenderer("ui/targetshader.png", "target_fbo") end

    Map:enableFBORenderer("target_fbo")

--  self.mm_fbo = core.display.newFBO(200, 200)
--  if self.mm_fbo then self.mm_fbo_shader = Shader.new("mm_fbo") if not self.mm_fbo_shader.shad then self.mm_fbo = nil self.mm_fbo_shader = nil end end

    self:setGamma(config.settings.gamma_correction / 100)
end

function _M:save()
	return class.save(self, self:defaultSavedFields{}, true)
end

function _M:getSaveDescription()
	return {
		name = self.player.name,
		description = ([[Exploring level %d of %s.]]):format(self.level.level, self.zone.name),
	}
end

function _M:getStore(def)
	return Store.stores_def[def]:clone()
end

function _M:leaveLevel(level, lev, old_lev)
	if level:hasEntity(self.player) then
		level.exited = level.exited or {}
		if lev > old_lev then
			level.exited.down = {x=self.player.x, y=self.player.y}
		else
			level.exited.up = {x=self.player.x, y=self.player.y}
		end
		level.last_turn = game.turn
		level:removeEntity(self.player)
	end
end

function _M:changeLevel(lev, zone)
	local old_lev = (self.level and not zone) and self.level.level or -1000
	local target_x = nil
	local target_y = nil
	local old_zone_name = nil
	local new_zone_name = nil
	local coords = nil

	if zone and self.player.on_leave_level and not self.player:on_leave_level() then
		self.logPlayer(self.player, "#LIGHT_RED#You cannot leave!")
        return
	end

	if self.zone then
		old_zone_name = self.zone.zone_key or self.zone.name or "none"
	end

	if self.zone and self.zone.on_leave then
        self.zone:on_leave(lev or -1000, old_lev, zone)
    end

	-- Changing zones
	if zone then
		if type(zone) == "string" then
			new_zone_name = zone
		else
			new_zone_name = zone.zone_key or zone.name or "none"
		end
	print ("[ITS] Leaving zone ", old_zone_name, "and entering new zone ", new_zone_name)
		-- Cleanup
		if self.zone then
			-- Save the departure point in the old zone, keyed on new zone name
			coords = {game.player.x, game.player.y}
			if not self.zone.entered_from then
				self.zone.entered_from = {}
	        end
			print ("[ITS] save departure point x,y ", game.player.x, game.player.y, " to zone ", new_zone_name)
			self.zone.entered_from[new_zone_name] = coords
			self.zone:leaveLevel(false, lev, old_lev)
			self.zone:leave()
		end
		-- Change zones
		if type(zone) == "string" then
			self.zone = Zone.new(zone)
		else
			self.zone = zone
		end
		-- Get previous departure point, if any
		if self.zone.entered_from and self.zone.entered_from[old_zone_name] then
			coords = self.zone.entered_from[old_zone_name]
			if coords then target_x, target_y = coords[1], coords[2] end
			print ("[ITS] read landing spot x,y ", target_x, target_y, "from ", old_zone_name)
		end
	end

	-- Generate new level
	self.zone:getLevel(self, lev, old_lev)

	-- Move player to correct spot
	if target_x then
		self.player:move(target_x, target_y, true)
	elseif lev > old_lev then
		self.player:move(self.level.default_up.x, self.level.default_up.y, true)
		coords = {self.level.default_up.x, self.level.default_up.y}
	else
		self.player:move(self.level.default_down.x, self.level.default_down.y, true)
		coords = {self.level.default_down.x, self.level.default_down.y}
	end

	-- If these don't already exist, save the way back
	if old_zone_name and not target_x then
		if not self.zone.entered_from then
                        self.zone.entered_from = {}
                end
		self.zone.entered_from[old_zone_name] = coords
		print ("[ITS] save new landing spot x,y ", game.player.x, game.player.y, " from zone ", old_zone_name)
	end

	if self.zone.on_enter then
        self.zone.on_enter(lev, old_lev, zone)
    end

    -- Music, sound, noises, dressing
    print("[ITS] preparing to do music")
    local musics = {}
    local keep_musics = false
    if self.level.data.ambient_music then
    	print("[DBG]there is level ambient music")
        if self.level.data.ambient_music ~= "last" then
            if type(self.level.data.ambient_music) == "string" then musics[#musics+1] = self.level.data.ambient_music
            elseif type(self.level.data.ambient_music) == "table" then for i, name in ipairs(self.level.data.ambient_music) do musics[#musics+1] = name end
            elseif type(self.level.data.ambient_music) == "function" then for i, name in ipairs{self.level.data.ambient_music()} do musics[#musics+1] = name end
            end
        elseif self.level.data.ambient_music == "last" then
            keep_musics = true
        end
    end
    if not keep_musics then self:playAndStopMusic(unpack(musics)) end
    print("[ITS] done prep music")

	self.level:addEntity(self.player)
end

function _M:getPlayer()
	return self.player
end

--- Says if this savefile is usable or not
function _M:isLoadable()
	return not self:getPlayer(true).dead
end

function _M:tick()
	if self.level then
		self:targetOnTick()

		engine.GameTurnBased.tick(self)
		-- Fun stuff: this can make the game realtime, although calling it in display() will make it work better
		-- (since display is on a set FPS while tick() ticks as much as possible
		-- engine.GameEnergyBased.tick(self)
	else
		engine.Game.tick(self)
	end
	-- When paused (waiting for player input) we return true: this means we wont be called again until an event wakes us
	if self.paused and not savefile_pipe.saving then return true end
end

--- Called every game turns
-- Does nothing, you can override it
function _M:onTurn()
    -- Allow zones to run turn logic
    if self.zone then
        if self.zone.on_turn then self.zone:on_turn() end
    end

	-- The following happens only every 10 game turns (once for every turn of 1 mod speed actors)
	if self.turn % 10 ~= 0 then return end

    -- log day turnover (really?)
    if not self.day_of_year or self.day_of_year ~= self.calendar:getDayOfYear(self.turn) then
        self.log(self.calendar:getTimeDate(self.turn))
        self.day_of_year = self.calendar:getDayOfYear(self.turn)
    end

	-- Process overlay effects
	self.level.map:processEffects()
end

-- nb_keyframes is the number of normalized frames that have passed since last call
function _M:display(nb_keyframes)
	-- If switching resolution, blank everything but the dialog
	if self.change_res_dialog then engine.GameTurnBased.display(self, nb_keyframes) return end

    if self.full_fbo then self.full_fbo:use(true) end

	-- Now the map, if any
	if self.level and self.level.map and self.level.map.finished then
		-- Display the map and compute FOV for the player if needed
		if self.level.map.changed then
			self.player:playerFOV()
		end

        -- Display using Framebuffer, so that we can use shaders and all
        local map = game.level.map
        if self.fbo then
            self.fbo:use(true)
            map:display(0, 0, nb_keyframes)
            if self.level.data.weather_particle then
                self.state:displayWeather(self.level, self.level.data.weather_particle, nb_keyframes)
            end
            if self.level.data.weather_shader then
                self.state:displayWeatherShader(self.level, self.level.data.weather_shader, map.display_x, map.display_y, nb_keyframes)
            end
            self.fbo:use(false, self.full_fbo)
            self.fbo:toScreen(map.display_x, map.display_y, map.viewport.width, map.viewport.height, self.fbo_shader.shad)
            if self.target then self.target:display() end
        else -- Basic display; no FBOs
		    self.level.map:display(nil, nil, nb_keyframes)
		    -- Display the targetting system if active
		    self.target:display()
        end

		-- And the minimap
		self.level.map:minimapDisplay(self.w - 200, 20, util.bound(self.player.x - 25, 0, self.level.map.w - 50), util.bound(self.player.y - 25, 0, self.level.map.h - 50), 50, 50, 0.6)
	end

	-- Play any ambient sounds
	if self.level and self.level.data and self.level.data.ambient_bg_sounds then
		self.state:playAmbientSounds(self.level, self.level.data.ambient_bg_sounds, nb_keyframes)
	end
    if self.level and self.level.map then
        self.level.map:displayEmotes(nb_keyframes or 1)
    end

	-- We display the player's interface
	self.player_display:toScreen(nb_keyframes)
	self.flash:toScreen(nb_keyframes)
	self.logdisplay:toScreen()
	if self.show_npc_list then
		self.npcs_display:toScreen()
	else
		self.hotkeys_display:toScreen()
	end
	self.bignews:display(nb_keyframes)
	if self.player then self.player.changed = false end

	-- Tooltip is displayed over all else
	self:targetDisplayTooltip()

	engine.GameTurnBased.display(self, nb_keyframes)

    if self.full_fbo then
      self.full_fbo:use(false)
      self.full_fbo:toScreen(0, 0, self.w, self.h, self.full_fbo_shader.shad)
   end
end

--- Setup the keybinds
function _M:setupCommands()
	-- Make targeting work
	self.normal_key = self.key
	self:targetSetupKey()

	-- One key handled for normal function
	self.key:unicodeInput(true)
	self.key:addBinds
	{
		-- Movements
		MOVE_LEFT = function() self.player:moveDir(4) end,
		MOVE_RIGHT = function() self.player:moveDir(6) end,
		MOVE_UP = function() self.player:moveDir(8) end,
		MOVE_DOWN = function() self.player:moveDir(2) end,
		MOVE_LEFT_UP = function() self.player:moveDir(7) end,
		MOVE_LEFT_DOWN = function() self.player:moveDir(1) end,
		MOVE_RIGHT_UP = function() self.player:moveDir(9) end,
		MOVE_RIGHT_DOWN = function() self.player:moveDir(3) end,
		MOVE_STAY = function() self.player:useEnergy() end,

		RUN_LEFT = function() self.player:runInit(4) end,
		RUN_RIGHT = function() self.player:runInit(6) end,
		RUN_UP = function() self.player:runInit(8) end,
		RUN_DOWN = function() self.player:runInit(2) end,
		RUN_LEFT_UP = function() self.player:runInit(7) end,
		RUN_LEFT_DOWN = function() self.player:runInit(1) end,
		RUN_RIGHT_UP = function() self.player:runInit(9) end,
		RUN_RIGHT_DOWN = function() self.player:runInit(3) end,

		-- Hotkeys
		HOTKEY_1 = function() self.player:activateHotkey(1) end,
		HOTKEY_2 = function() self.player:activateHotkey(2) end,
		HOTKEY_3 = function() self.player:activateHotkey(3) end,
		HOTKEY_4 = function() self.player:activateHotkey(4) end,
		HOTKEY_5 = function() self.player:activateHotkey(5) end,
		HOTKEY_6 = function() self.player:activateHotkey(6) end,
		HOTKEY_7 = function() self.player:activateHotkey(7) end,
		HOTKEY_8 = function() self.player:activateHotkey(8) end,
		HOTKEY_9 = function() self.player:activateHotkey(9) end,
		HOTKEY_10 = function() self.player:activateHotkey(10) end,
		HOTKEY_11 = function() self.player:activateHotkey(11) end,
		HOTKEY_12 = function() self.player:activateHotkey(12) end,
		HOTKEY_SECOND_1 = function() self.player:activateHotkey(13) end,
		HOTKEY_SECOND_2 = function() self.player:activateHotkey(14) end,
		HOTKEY_SECOND_3 = function() self.player:activateHotkey(15) end,
		HOTKEY_SECOND_4 = function() self.player:activateHotkey(16) end,
		HOTKEY_SECOND_5 = function() self.player:activateHotkey(17) end,
		HOTKEY_SECOND_6 = function() self.player:activateHotkey(18) end,
		HOTKEY_SECOND_7 = function() self.player:activateHotkey(19) end,
		HOTKEY_SECOND_8 = function() self.player:activateHotkey(20) end,
		HOTKEY_SECOND_9 = function() self.player:activateHotkey(21) end,
		HOTKEY_SECOND_10 = function() self.player:activateHotkey(22) end,
		HOTKEY_SECOND_11 = function() self.player:activateHotkey(23) end,
		HOTKEY_SECOND_12 = function() self.player:activateHotkey(24) end,
		HOTKEY_THIRD_1 = function() self.player:activateHotkey(25) end,
		HOTKEY_THIRD_2 = function() self.player:activateHotkey(26) end,
		HOTKEY_THIRD_3 = function() self.player:activateHotkey(27) end,
		HOTKEY_THIRD_4 = function() self.player:activateHotkey(28) end,
		HOTKEY_THIRD_5 = function() self.player:activateHotkey(29) end,
		HOTKEY_THIRD_6 = function() self.player:activateHotkey(30) end,
		HOTKEY_THIRD_7 = function() self.player:activateHotkey(31) end,
		HOTKEY_THIRD_8 = function() self.player:activateHotkey(32) end,
		HOTKEY_THIRD_9 = function() self.player:activateHotkey(33) end,
		HOTKEY_THIRD_10 = function() self.player:activateHotkey(34) end,
		HOTKEY_THIRD_11 = function() self.player:activateHotkey(35) end,
		HOTKEY_THIRD_12 = function() self.player:activateHotkey(36) end,
		HOTKEY_PREV_PAGE = function() self.player:prevHotkeyPage() end,
		HOTKEY_NEXT_PAGE = function() self.player:nextHotkeyPage() end,

		-- Actions
		CHANGE_LEVEL = function()
			if not self.level and self.level.map then
				self.log("You cannot do that here.")
			end
			local e = self.level.map(self.player.x, self.player.y, Map.TERRAIN)
			if self.player:enoughEnergy() and e.change_level then
				self:changeLevel(e.change_zone and e.change_level or self.level.level + e.change_level, e.change_zone)
			else
				self.log("There is no way out of this level here.")
			end
		end,

		REST = function()
			self.player:restInit()
		end,

		PICKUP_FLOOR = function()
			if self.player.no_inventory_access then return end
			self.player:playerPickup()
		end,
		DROP_FLOOR = function()
			if self.player.no_inventory_access then return end
			self.player:playerDrop()
		end,

		SHOW_INVENTORY = function()
			if self.player.no_inventory_access then return end
			local d
			d = self.player:showEquipInven("Inventory", nil, function(o, inven, item, button, event)
			    if not o then return end
			    local ud = require("mod.dialogs.UseItemDialog").new(event == "button", self.player, o, item, inven, function(_, _, _, stop)
			        d:generate()
			        d:generateList()
			        if stop then self:unregisterDialog(d) end
			    end)
			    self:registerDialog(ud)
			end)
		end,

		SHOW_LOCKPICKUI = function()
			-- if self.player.no_inventory_access then return end
			local d
			d = self.player:showLockpick("Lockpick", nil, function(o, inven, item, button, event)
			    if not o then return end
			    local ud = require("mod.dialogs.UseItemDialog").new(event == "button", self.player, o, item, inven, function(_, _, _, stop)
			        d:generate()
			        d:generateList()
			        if stop then self:unregisterDialog(d) end
			    end)
			    self:registerDialog(ud)
			end)
		end,

		USE_TALENTS = function()
			self.player:useTalents()
		end,

		SHOW_QUESTS = function()
                        self:registerDialog(require("engine.dialogs.ShowQuests").new(self.player))
                end,

		SAVE_GAME = function()
			self:saveGame()
		end,

		SHOW_CHARACTER_SHEET = function()
			self:registerDialog(require("mod.dialogs.CharacterSheet").new(self.player))
		end,

		-- Exit the game
		QUIT_GAME = function()
			self:onQuit()
		end,

		SCREENSHOT = function() self:saveScreenshot() end,

		EXIT = function()
			local menu menu = require("engine.dialogs.GameMenu").new{
				"resume",
				"keybinds",
				"video",
				"save",
				"quit"
			}
			self:registerDialog(menu)
		end,

		-- Lua console, you probably want to disable it for releases
		LUA_CONSOLE = function()
			self:registerDialog(DebugConsole.new())
		end,

		-- Toggle monster list
		TOGGLE_NPC_LIST = function()
			self.show_npc_list = not self.show_npc_list
			self.player.changed = true
		end,

		TACTICAL_DISPLAY = function()
			if Map.view_faction then
				self.always_target = nil
				Map:setViewerFaction(nil)
			else
				self.always_target = true
				Map:setViewerFaction("players")
			end
		end,

		LOOK_AROUND = function()
			self.flash:empty(true)
			self.flash(self.flash.GOOD, "Looking around... (direction keys to select interesting things, shift+direction keys to move freely)")
			local co = coroutine.create(function() self.player:getTarget{type="hit", no_restrict=true, range=2000} end)
			local ok, err = coroutine.resume(co)
			if not ok and err then print(debug.traceback(co)) error(err) end
		end,
	}
	self.key:setCurrent()
end

function _M:setupMouse(reset)
	if reset then self.mouse:reset() end
	self.mouse:registerZone(Map.display_x, Map.display_y, Map.viewport.width, Map.viewport.height, function(button, mx, my, xrel, yrel, bx, by, event)
		-- Handle targeting
		if self:targetMouse(button, mx, my, xrel, yrel, event) then return end

		-- Handle the mouse movement/scrolling
		self.player:mouseHandleDefault(self.key, self.key == self.normal_key, button, mx, my, xrel, yrel, event)
	end)
	-- Scroll message log
	self.mouse:registerZone(self.logdisplay.display_x, self.logdisplay.display_y, self.w, self.h, function(button)
		if button == "wheelup" then self.logdisplay:scrollUp(1) end
		if button == "wheeldown" then self.logdisplay:scrollUp(-1) end
	end, {button=true})
	-- Use hotkeys with mouse
	self.mouse:registerZone(self.hotkeys_display.display_x, self.hotkeys_display.display_y, self.w, self.h, function(button, mx, my, xrel, yrel, bx, by, event)
		self.hotkeys_display:onMouse(button, mx, my, event == "button", function(text) self.tooltip:displayAtMap(nil, nil, self.w, self.h, tostring(text)) end)
	end)
	self.mouse:setCurrent()
end

--- Ask if we really want to close, if so, save the game first
function _M:onQuit()
	self.player:restStop()

	if not self.quit_dialog then
		self.quit_dialog = QuitDialog.new()
		self:registerDialog(self.quit_dialog)
	end
end

--- Requests the game to save
function _M:saveGame()
	-- savefile_pipe is created as a global by the engine
	savefile_pipe:push(self.save_name, "game", self)
	self.log("Saving game...")
end
