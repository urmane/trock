
name = "Elemental Quests"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "Complete all the elemental quests."
	if self:isCompleted("earth-quest") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have completed the Earth Quest!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must explore Murmon, in the middle of Atarlo, and do the thing.#WHITE#"
	end
	if self:isCompleted("fire-quest") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have completed the Fire Quest!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must complete the Fire Quest.#WHITE#"
	end
	if self:isCompleted("water-quest") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have completed the Water Quest!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must complete the Water Quest.#WHITE#"
	end
	if self:isCompleted("air-quest") then
		desc[#desc+1] = "#LIGHT_GREEN#* You have completed the Air Quest!#WHITE#"
	else
		desc[#desc+1] = "#SLATE#* You must complete the Air Quest.#WHITE#"
	end

	return table.concat(desc, "\n")
end

on_status_change = function(self, who, status, sub)
	if sub then
		if self:isCompleted("earth-quest") and
		   self:isCompleted("fire-quest") and
		   self:isCompleted("water-quest") and
		   self:isCompleted("air-quest") then
			who:setQuestStatus(self.id, engine.Quest.COMPLETED)
		end
	end
end
