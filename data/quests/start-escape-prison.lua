
name = "Find Gora Sewers"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "You must escape from Gora Prison and back to the world, but you cannot get out of the main entrance."
	desc[#desc+1] = "You must find a passage to the sewers beneath the prison."
	return table.concat(desc, "\n")
end
