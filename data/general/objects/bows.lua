-- sourced from TOME's bows.lua
local Talents = require "engine.interface.ActorTalents"

newEntity{
        define_as = "BASE_BOW", slot = "WEAPON", slot_forbid = "SHIELD",
        type = "weapon", subtype="bow",
        display = "}", color=colors.UMBER,
        encumber = 4, rarity = 7,
        combat = { talented = "bow", sound = "actions/arrow", sound_miss = "actions/arrow",},
        -- archery = "bow",
        desc = [[Bows are used to shoot arrows.]],
}

newEntity{ base = "BASE_BOW", name = "shortbow", level_range = {1, 10}, cost = 5, combat = { range = 6, physspeed = 0.8, }, }
newEntity{ base = "BASE_BOW", name = "longbow", level_range = {1, 10}, cost = 5, combat = { range = 6, physspeed = 0.8, }, }
newEntity{ base = "BASE_BOW", name = "thief's bow", level_range = {1, 10}, cost = 5, combat = { range = 6, physspeed = 0.8, }, }

newEntity{
        define_as = "BASE_ARROW", slot = "QUIVER", type = "ammo", subtype="arrow",
        add_name = " (#COMBAT_AMMO#)",
        display = "{", color=colors.UMBER,
        encumber = 3, rarity = 7,
        combat = { talented = "bow", damrange = 1.4, },
        archery_ammo = "bow",
        desc = [[Arrows are used with bows to pierce your foes to death.]],
}

newEntity{ base = "BASE_ARROW",
        name = "quiver of elm arrows", short_name = "elm",
        level_range = {1, 10},
        require = { stat = { dex=11 }, },
        cost = 2,
        material_level = 1,
        combat = {
                capacity = resolvers.rngavg(5, 15),
                dam = resolvers.rngavg(7,12),
                apr = 5,
                physcrit = 1,
                dammod = {dex=0.7, str=0.5},
        },
}

