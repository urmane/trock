newTalentType{ type="thief/mechanic", name = "mechanic", description = "Mechanical techniques" }

newTalent{
    name = "Pick locks",
    short_name = "Lockpick",
    type = {"thief/mechanic", 1},
    mode = "activated", -- changed this from passive / Use on a lockpick, cleaner
    image = "talents/picklocks.png",
    info = "The ability to unlock locks without the intended key",
    points = 8,
    range = 2,
    cooldown = 2,
    power = 2,
    action = function(self, t)
    end,
    on_learn = function(self) return "Hey, I learned how to pick locks!" end,
    on_unlearn = function(self) return "Hey, I forgot how to pick locks!" end,
}

newTalent{
    name = "Disarm Trap",
    short_name = "Disarm Trap",
    type = {"thief/mechanic", 1},
    mode = "activated",
    info = "Skill at disarming traps",
}

newTalent{
    name = "Disable Mechanism",
    short_name = "Disable",
    type = {"thief/mechanic", 1},
    mode = "activated",
    info = "Skill at disabling mechanisms",
}

newTalent{
    name = "Set Trap",
    short_name = "Set Trap",
    type = {"thief/mechanic", 1},
    mode = "activated",
    info = "Skill at creating traps",
}

