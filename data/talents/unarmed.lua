newTalentType{ type="combat/unarmed", name = "unarmed", description = "Unarmed combat techniques" }
newTalent{
    name = "Disarm",
    short_name = "Disarm",
    type = {"combat/unarmed", 1},
    info = "Disarm target",
    mode = "activated",
}
newTalent{
    name = "Throw",
    short_name = "Throw",
    type = {"combat/unarmed", 1},
    info = "Throw target",
    mode = "activated",
}

newTalent{
    name = "Kick",
    type = {"combat/unarmed", 1},
    points = 1,
    cooldown = 6,
    power = 2,
    range = 1,
    action = function(self, t)
        local tg = {type="hit", range=self:getTalentRange(t)}
        local x, y, target = self:getTarget(tg)
        if not x or not y or not target then return nil end
        if core.fov.distance(self.x, self.y, x, y) > 1 then return nil end

        target:knockback(self.x, self.y, 2 + self:getDex())
        return true
    end,
    info = function(self, t)
        return "Kick!"
    end,
}
newTalent{
    name = "Acid Spray",
    type = {"combat/unarmed", 1},
    points = 1,
    cooldown = 6,
    power = 2,
    range = 6,
    action = function(self, t)
        local tg = {type="ball", range=self:getTalentRange(t), radius=1, talent=t}
        local x, y = self:getTarget(tg)
        if not x or not y then return nil end
        self:project(tg, x, y, DamageType.ACID, 1 + self:getDex(), {type="acid"})
        return true
    end,
    info = function(self, t)
        return "Zshhhhhhhhh!"
    end,
}

