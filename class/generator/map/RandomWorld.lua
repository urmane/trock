
require "engine.class"
local Map = require "engine.Map"
require "engine.Generator"

module(..., package.seeall, class.inherit(engine.Generator))

function _M:init(zone, map, level, data)
	engine.Generator.init(self, zone, map, level)
        self.data = data
	self.map = map
	self.width = data.width or 256
	self.height = data.height or 256
	self.border_div = data.border_div or 0
	self.border_terrain = data.border_terrain or "ocean"
        self.grid_list = self.zone.grid_list
	self.subgen = {}
	self.spots = {}
        self.min_land = data.min_land or 12000   -- Dependent on w and h!!
        self.noise = data.noise or "simplex"
	data.__import_offset_x = data.__import_offset_x or 0
        data.__import_offset_y = data.__import_offset_y or 0

	self:loadMap(data.map)
end

function _M:loadMap(file)
        local t = {}

	-- This reads in lua code specific to this zone map, including
	-- subgenerator info, tiles, encounter placement, etc
	print("[ITS] RandomWorld init using file", "/data/maps/"..file..".lua")
        local f, err = loadfile("/data/maps/"..file..".lua")
        if not f and err then error(err) end
	-- This whole parse function copied from Static.lua - not sure what I need at this point
        local g = {
                level = self.level,
                zone = self.zone,
                data = self.data,
                Map = require("engine.Map"),
                specialList = function(kind, files)
                        if kind == "terrain" then
                                self.grid_list = self.zone.grid_class:loadList(files)
                        elseif kind == "trap" then
                                self.trap_list = self.zone.trap_class:loadList(files)
                        elseif kind == "object" then
                                self.object_list = self.zone.object_class:loadList(files)
                        elseif kind == "actor" then
                                self.npc_list = self.zone.npc_class:loadList(files)
                        else
                                error("kind unsupported")
                        end
                end,
                subGenerator = function(g)
                        self.subgen[#self.subgen+1] = g
                end,
		setBorderDiv = function(x)
			self.border_div = x
		end,
		setBorderTerrain = function(str)
			self.border_terrain = str
		end,
                addTown = function(dst, type, subtype, additional)
                        local spot = {x=self.data.__import_offset_x+dst[1], y=self.data.__import_offset_y+dst[2], type=type or "static", subtype=subtype or "static"}
                        table.update(spot, additional or {})
                        self.spots[#self.spots+1] = spot
                end,
                defineTile = function(char, grid, obj, actor, trap, status, spot)
                        t[char] = {grid=grid, object=obj, actor=actor, trap=trap, status=status, define_spot=spot}
                end,
                quickEntity = function(char, e, status, spot)
                        if type(e) == "table" then
                                local e = self.zone.grid_class.new(e)
                                t[char] = {grid=e, status=status, define_spot=spot}
                        else
                                t[char] = t[e]
                        end
                end,
                prepareEntitiesList = function(type, class, file)
                        local list = require(class):loadList(file)
                        self.level:setEntitiesList(type, list, true)
                end,
                prepareEntitiesRaritiesList = function(type, class, file)
                        local list = require(class):loadList(file)
                        list = game.zone:computeRarities(type, list, game.level, nil)
                        self.level:setEntitiesList(type, list, true)
                end,
                setStatusAll = function(s) self.status_all = s end,
                addData = function(t)
                        table.merge(self.level.data, t, true)
                end,
                getMap = function(t)
                        return self.map
                end,
                checkConnectivity = function(dst, src, type, subtype)
                        self.spots[#self.spots+1] = {x=dst[1], y=dst[2], check_connectivity=src, type=type or "static", subtype=subtype or "static"}
                end,
                addSpot = function(dst, type, subtype, additional)
                        local spot = {x=self.data.__import_offset_x+dst[1], y=self.data.__import_offset_y+dst[2], type=type or "static", subtype=subtype or "static"}
                        table.update(spot, additional or {})
                        self.spots[#self.spots+1] = spot
                end,
                addZone = function(dst, type, subtype, additional)
                        local zone = {x1=self.data.__import_offset_x+dst[1], y1=self.data.__import_offset_y+dst[2], x2=self.data.__import_offset_x+dst[3], y2=self.data.__import_offset_y+dst[4], type=type or "static", subtype=subtype or "static", additional=additional}
                        table.update(zone, additional or {})
                        self.map.custom_zones = self.map.custom_zones or {}
                        self.map.custom_zones[#self.map.custom_zones+1] = zone
                end,
        }
        setfenv(f, setmetatable(g, {__index=_G}))
        local ret, err = f()
	-- Make sure the map file returns true
        if not ret and err then error(err) end

        self.map.startx = self.zone.startx or g.startx or math.floor(self.map.w / 2)
        self.map.starty = self.zone.starty or g.starty or math.floor(self.map.h / 2)
        self.map.endx = self.zone.endx or g.endx or math.floor(self.map.w / 2)
        self.map.endy = self.zone.endy or g.endy or math.floor(self.map.h / 2)

        self.tiles = self.tiles or {}
        self.tiles = table.merge(self.tiles, t)

        print("[ITS] map size", self.map.w, self.map.h)
end

--function _M:resolve(typ, c)
 --       if not self.tiles[c] or not self.tiles[c][typ] then return end
  --      local res = self.tiles[c][typ]
-- or this:	local res = self.tiles[c]["grid"]
   --     if type(res) == "function" then
    --            return self.grid_list[res()]
     --   elseif type(res) == "table" and res.__CLASSNAME then
      --          return res
       -- elseif type(res) == "table" then
--                return self.grid_list[res[rng.range(1, #res)]]
 --       else
  --              return self.grid_list[res]
   --     end
--end

function _M:generate(lev, old_lev)
	-- Random-noise generator, with Static subgenerators
	print("[ITS] Generating RandomWorld")
        local noise = core.noise.new(2, self.data.hurst, self.data.lacunarity)
        local fills = {}
        local opens = {}
        local list = {}
	local border_width = 0

	print("[ITS] Generating initial terrain")
        for i = 0, self.map.w - 1 do
                opens[i] = {}
                for j = 0, self.map.h - 1 do
			-- code these better
			height = noise[self.noise](noise, self.data.zoom * i / self.map.w, self.data.zoom * j / self.map.h, self.data.octave)
			if height > self.data.mountain_height then
                                self.map(i, j, Map.TERRAIN, self:resolve("mountain"))
                                opens[i][j] = #list+1
                                list[#list+1] = {x=i, y=j}
			elseif height > self.data.forest_height then
                                self.map(i, j, Map.TERRAIN, self:resolve("trees"))
                                opens[i][j] = #list+1
                                list[#list+1] = {x=i, y=j}
			elseif height > 0 then
				if ( j < self.data.ice_width ) or ( j > self.map.h - self.data.ice_width ) then
                                	self.map(i, j, Map.TERRAIN, self:resolve("snow"))
				else
                                	self.map(i, j, Map.TERRAIN, self:resolve("land"))
				end
                                opens[i][j] = #list+1
                                list[#list+1] = {x=i, y=j}
			elseif height > self.data.deepocean_depth then
				if ( j < self.data.ice_width ) or ( j > self.map.h - self.data.ice_width ) then
                                	self.map(i, j, Map.TERRAIN, self:resolve("ice"))
                        	else
                                	self.map(i, j, Map.TERRAIN, self:resolve("ocean"))
                        	end
                        else
				-- deepocean remains deep, no ice
                                self.map(i, j, Map.TERRAIN, self:resolve("deepocean"))
                        end
                end
        end
	if self.border_div then
		print("[ITS] Creating border")
		-- border is min(1, map.w/border_div)
		if self.map.w > self.border_div then
			border_width = self.map.w / self.border_div
		else
			border_width = 1
		end
        	for i = 0, self.map.w - 1 do
                	for j = 0, self.map.h - 1 do
				-- Remember 0-based vs 1-based, north/south polar seas
				if j < border_width or j >= (self.map.h - border_width) then
					self.map(i, j, Map.TERRAIN, self:resolve("ice"))
                        	elseif i < border_width or i >= (self.map.w - border_width) then
                                	self.map(i, j, Map.TERRAIN, self:resolve(self.border_terrain))
				end
			end
		end
	end

-- Erm do I need any of this?
--[[
        local floodFill floodFill = function(x, y)
                local q = {{x=x,y=y}}
                local closed = {}
                while #q > 0 do
                        local n = table.remove(q, 1)
                        if opens[n.x] and opens[n.x][n.y] then
                                closed[#closed+1] = n
                                list[opens[n.x][n.y] ] = nil
                                opens[n.x][n.y] = nil
                                q[#q+1] = {x=n.x-1, y=n.y}
                                q[#q+1] = {x=n.x, y=n.y+1}
                                q[#q+1] = {x=n.x+1, y=n.y}
                                q[#q+1] = {x=n.x, y=n.y-1}

                                q[#q+1] = {x=n.x+1, y=n.y-1}
                                q[#q+1] = {x=n.x+1, y=n.y+1}
                                q[#q+1] = {x=n.x-1, y=n.y-1}
                                q[#q+1] = {x=n.x-1, y=n.y+1}
                        end
                end
                return closed
        end

        -- Process all open spaces
        local groups = {}
        while next(list) do
                local i, l = next(list)
                local closed = floodFill(l.x, l.y)
                groups[#groups+1] = {id=id, list=closed}
                print("Floodfill group", i, #closed)
        end
        -- If nothing exists, regen
        if #groups == 0 then return self:generate(lev, old_lev) end

        -- Sort to find the biggest group
        table.sort(groups, function(a,b) return #a.list < #b.list end)
        local g = groups[#groups]
        if #g.list >= self.min_land then
                for i = 1, #groups-1 do
                        for j = 1, #groups[i].list do
                                local jn = groups[i].list[j]
                                self.map(jn.x, jn.y, Map.TERRAIN, self:resolve("ocean"))
                        end
                end
        else
                print("[ITS] map not OK - regenerate")
                return self:generate(lev, old_lev)
        end
--]]

	self:triggerHook{"MapGeneratorRandomWorld:subgenRegister", mapfile=self.data.map, list=self.subgen}

	print("[ITS] adding static overlays")
        for i = 1, #self.subgen do
                local g = self.subgen[i]
                local data = g.data
                if type(data) == "string" and data == "pass" then data = self.data end

                local map = self.zone.map_class.new(g.w, g.h)
                data.__import_offset_x = self.data.__import_offset_x+g.x
                data.__import_offset_y = self.data.__import_offset_y+g.y
                local generator = require(g.generator).new(
                        self.zone,
                        map,
                        self.level,
                        data
                )
                local ux, uy, dx, dy, subspots = generator:generate(lev, old_lev)

                if g.overlay then
                        self.map:overlay(map, g.x, g.y)
                else
                        self.map:import(map, g.x, g.y)
                end

                table.append(self.spots, subspots)

                --if g.define_up then self.gen_map.startx, self.gen_map.starty = ux + self.data.__import_offset_x+g.x, uy + self.data.__import_offset_y+g.y end
                --if g.define_down then self.gen_map.endx, self.gen_map.endy = dx + self.data.__import_offset_x+g.x, dy + self.data.__import_offset_y+g.y end
        end

	-- cheeseball, make this actually random
	-- loop thru collecting spots and do a table.rng thing, or place as an island?
	-- also needs to check no other town/dungeon is already there
        local findRandomMapTerrain findRandomMapTerrain = function(x1, y1, x2, y2, str)
		for i = x1, x2 do
			for j = y1, y2 do
				if self.map(i, j, Map.TERRAIN).name == str then
					return i, j
				end
			end
		end
	end

	print("[ITS] place additional map features")
	-- go thru spots, foreach town find land i,j near spot x,y and assign
        for i = 1, #self.map.custom_zones do
		x, y = findRandomMapTerrain(self.map.custom_zones[i].x1, self.map.custom_zones[i].y1, self.map.custom_zones[i].x2, self.map.custom_zones[i].y2, "land")
		addl = "none"
		if self.map.custom_zones[i].additional then
			addl = self.map.custom_zones[i].additional[1]
		end
		print("[ITS] Placing ",self.map.custom_zones[i].type or "nil", ",",
			self.map.custom_zones[i].subtype, " called ", addl, " at ", x, y)
		self.map(x, y, Map.TERRAIN, self:resolve(addl))
		
		coords = {x, y}
		if not self.zone.entered_from then
                	self.zone.entered_from = {}
		end
                self.zone.entered_from[addl] = coords

		if self.map.custom_zones[i].type == "town" then
		elseif self.map.custom_zones[i].type == "dungeon" then
		else
			print("[ITS] not yet placing ", self.map.custom_zones[i].type or "nil", ",", self.map.custom_zones[i].subtype)
		end
	end

	print("[ITS] RandomWorld generation complete - start/end x/y", self.map.startx, self.map.starty, self.map.endx, self.map.endy)
        return self.map.startx, self.map.starty, self.map.endx, self.map.endy, self.spots
end
