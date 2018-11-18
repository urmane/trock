--[[
Cannot subclass Map, get this:

Initiated zone  Gora Prison     with base_level 1
Loading zone persistance level  gora-prison     1
Creating level  gora-prison     1
Lua Error: /engine/Map.lua:238: attempt to index field 'viewport' (a nil value)
        At [C]:-1 __index
        At /engine/Map.lua:238 makeCMap
        At /engine/Map.lua:283 loaded
        At /engine/Map.lua:215 init
        At /engine/class.lua:39 new
        At /engine/Zone.lua:879 newLevel
        At /engine/Zone.lua:829 getLevel
        At /mod/class/Game.lua:254 changeLevel
        At /mod/class/Game.lua:125 at_end
        At /engine/Birther.lua:271 next
        At /engine/Birther.lua:147 on_register
        At /engine/Game.lua:328 registerDialog
        At /mod/class/Game.lua:150 newGame
        At /mod/class/Game.lua:85 run
        At /engine/Module.lua:850 instanciate
        At /engine/utils.lua:2199 showMainMenu
        At /engine/init.lua:156 
        At [C]:-1 dofile
        At /loader/init.lua:196 
]]--


require "engine.class"
--require "engine.Map"
local Map = require "engine.Map"

print("[ITS] Loading Map")

--- Represents a level map, handles display and various low level map work
module(..., package.seeall, class.inherit(Map))

--[[

--- Displays the map on screen
-- @param x the coord where to start drawing, if null it uses self.display_x
-- @param y the coord where to start drawing, if null it uses self.display_y
-- @param nb_keyframes the number of keyframes elapsed since last draw
-- @param always_show tell the map code to force display unseed entities as remembered (used for smooth FOV shading)
function _M:display(x, y, nb_keyframe, always_show, prevfbo)
	nb_keyframes = nb_keyframes or 1
	local ox, oy = self.display_x, self.display_y
	self.display_x, self.display_y = x or self.display_x, y or self.display_y

	self._map:toScreen(self.display_x, self.display_y, nb_keyframe, always_show, self.changed, prevfbo)

	self.display_x, self.display_y = ox, oy

	self:removeParticleEmitters()
	print("[DEBUG]running displayEmotes")
	self:displayEmotes(nb_keyframe)

	-- If nothing changed, return the same surface as before
	if not self.changed then return end
	self.changed = false
	self.clean_fov = true
end

--- Temp debug fn
function _M:displayEmotes(nb_keyframes)
    local del = {}
    local e = next(self.emotes)
    --local sx, sy = self._map:getScroll()
    while e do
        print("[DBG] display emote here")
        e = next(self.emotes, e)
    end
    for i = 1, #del do self.emotes[del[i] ] = nil end
end

--]]


