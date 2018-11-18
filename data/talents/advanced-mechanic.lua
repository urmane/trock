newTalentType{ type="thief/advanced-mechanic", name = "advanced-mechanic", description = "Advanced mechanical techniques" }
newTalent{
    name = "Autoswipe",
    short_name = "Autoswipe",
    type = {"thief/advanced-mechanic", 1},
    info = "Automatically pick the pockets of those you pass near",
    mode = "passive",
    require = { stat = { str = 10, dex = 10 }, talent = { Talents.T_LOCKPICK }, },
}

newTalent{
    name = "Autodark",
    short_name = "Autodark",
    type = {"thief/advanced-mechanic", 1},
    info = "Automatically extinguish light sources you pass near",
    mode = "passive",
    require = { stat = { str = 10, dex = 10 }, talent = { Talents.T_LOCKPICK }, },
}

newTalent{
    name = "Autodisarm",
    short_name = "Autodisarm",
    type = {"thief/advanced-mechanic", 1},
    info = "Automatically disarms traps you pass near",
    mode = "passive",
    require = { stat = { str = 10, dex = 10 }, talent = { Talents.T_LOCKPICK }, },
}

newTalent{
    name = "Autounlock",
    short_name = "Autounlock",
    type = {"thief/advanced-mechanic", 1},
    info = "Automatically open locks you pass near",
    mode = "passive",
    require = { stat = { str = 10, dex = 10 }, talent = { Talents.T_LOCKPICK }, },
}

newTalent{
    name = "Autohide",
    short_name = "Autohide",
    type = {"thief/advanced-mechanic", 1},
    info = "Automatically Leap to Shaddows or Hide when you are seen",
    mode = "sustained",
    require = { stat = { str = 10, dex = 10 }, talent = { Talents.T_LOCKPICK }, },
}

