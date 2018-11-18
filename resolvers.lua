-- Resolves equipment creation for an actor
function resolvers.equip(t)
    return {__resolver="equip", __resolve_last=true, t}
end
function resolvers.equipbirth(t)
    for i, filter in ipairs(t) do
        filter.ignore_material_restriction = true
    end
    return {__resolver="equip", __resolve_last=true, t}
end
--- Actually resolve the equipment creation
function resolvers.calc.equip(t, e)
  print("Equipment resolver for", e.name)
    -- Iterate of object requests, try to create them and equip them
    for i, filter in ipairs(t[1]) do
      print("Equipment resolver", e.name, filter.type, filter.subtype, filter.defined)
        local o
        if not filter.defined then
            o = game.zone:makeEntity(game.level, "object", filter, nil, true)
        else
            local forced
            o, forced = game.zone:makeEntityByName(game.level, "object", filter.defined, filter.random_art_replace and true 
or false)
            -- If we forced the generation this means it was already found
            if forced then
--              print("Serving unique "..o.name.." but forcing replacement drop")
                filter.random_art_replace.chance = 100
            end
        end
        if o then
          print("Zone made us an equipment according to filter!", o:getName())

--            -- curse (done here to ensure object attributes get applied correctly)
--            if e:knowTalent(e.T_DEFILING_TOUCH) then
--                local t = e:getTalentFromId(e.T_DEFILING_TOUCH)
--                t.curseItem(e, t, o)
--            end

            -- Auto alloc some stats to be able to wear it
            if filter.autoreq and rawget(o, "require") and rawget(o, "require").stat then
--              print("Autorequire stats")
                for s, v in pairs(rawget(o, "require").stat) do
                    if e:getStat(s) < v then
                        e.unused_stats = e.unused_stats - (v - e:getStat(s))
                        e:incStat(s, v - e:getStat(s))
                    end
                end
            end
            -- Do not drop it unless it is an ego or better
 --           if not o.unique then o.no_drop = true --[[print(" * "..o.name.." => no drop")]] end
 --           if filter.force_drop then o.no_drop = nil end
 --           if filter.never_drop then o.no_drop = true end
            game.zone:addEntity(game.level, o, "object")

--            if t[1].id then o:identify(t[1].id) end

--            if filter.random_art_replace then
--                o.__special_boss_drop = filter.random_art_replace
--            end
        end
    end
    -- Delete the origin field
    return nil
end

--- Resolves drops creation for an actor
function resolvers.store(def, faction, door, sign)
    return {__resolver="store", def, faction, door, sign}
end
--- Actually resolve the drops creation
function resolvers.calc.store(t, e)
    if t[3] then
        e.image = t[3]
        if t[4] then e.add_mos = {{display_x=0.6, image=t[4]}} end
    end

    e.store_faction = t[2]
    t = t[1]

    e.block_move = function(self, x, y, who, act, couldpass)
        if who and who.player and act then
--            if self.store_faction and who:reactionToward({faction=self.store_faction}) < 0 then return true end
            self.store:loadup(game.level, game.zone)
            self.store:interact(who, self.name)
        end
        return true
    end
    e.store = game:getStore(t)
    e.store.faction = e.store_faction
    
    print("[STORE] created for entity", t, e, e.name)

    -- Delete the origin field
    return nil
end

