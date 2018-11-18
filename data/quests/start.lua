
name = "Escape From Gora Prison"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "You must escape from Gora Prison and back to the world, but you cannot get out of the main entrance.  Look for a back way ..."
	if self:isCompleted("start-escape-prison") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have found a way into the sewers beneath Gora Prison!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must find a passage to the sewers beneath the prison.#WHITE#"
	end
	if self:isCompleted("start-escape-sewers") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have discovered an escape from the sewers ... but they exit in a graveyard.#WHITE#"
	elseif self:isStatus(COMPLETED, "start-escape-sewers") then
		desc[#desc+1] = "#SLATE#* You must navigate the sewers to find an exit.#WHITE#"
	end
	if self:isCompleted("start-escape-graveyard") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have escaped the prison and the graveyard!#WHITE#"
	elseif self:isStatus(COMPLETED, "start-escape-graveyard") then
		desc[#desc+1] = "#SLATE#* You must make your way back to the world.#WHITE#"
	end
	return table.concat(desc, "\n")
end

on_status_change = function(self, who, status, sub)
	if sub then
		if self:isCompleted("start-escape-prison") and self:isCompleted("start-escape-sewers") and self:isCompleted("start-escape-graveyard") then
			who:setQuestStatus(self.id, engine.Quest.COMPLETED)
		end
	end
end
