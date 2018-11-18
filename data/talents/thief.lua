newTalentType{ type="thief/thief", name = "thief", description = "Standard thief abilities" }

newTalent{
    name = "Pick Pockets",
    type = {"thief/thief", 1},
    info = "Liberate items from the confines of pockets",
    mode = "activated",
    -- Naw, allow pick pockets while Hide is on, I like that tactic
    -- on_pre_use = function(self, t)
    --     if self:attr("never_move") then return false end
    --     return true
    -- end,

}

newTalent{
    name = "Sap",
    short_name = "Sap",
    type = {"thief/thief", 1},
    info = "Render unsuspecting target unconscious with a blow to the head",
    mode = "activated",
}

newTalent{
    name = "Backstab",
    short_name = "Backstab",
    type = {"thief/thief", 1},
    info = "Attack an unsupecting foe from behind",
    mode = "activated",
}
