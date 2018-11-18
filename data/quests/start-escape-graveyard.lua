
name = "Escape Gora Graveyard"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "You must find a way out of the graveyard ... without dying!"
	return table.concat(desc, "\n")
end
