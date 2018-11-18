
name = "Double Macguffin"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "Return the macguffin to the son."
	if self:isCompleted("macguffin-returned") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have returned the macguffin!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must return the macguffin to the son.#WHITE#"
	end
	return table.concat(desc, "\n")
end

on_status_change = function(self, who, status, sub)
	if sub then
		if self:isCompleted("macguffin-returned") then
			who:setQuestStatus(self.id, engine.Quest.COMPLETED)
		end
	end
end
