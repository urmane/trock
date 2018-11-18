
name = "Navigate Gora Sewers"
desc = function(self, who)
	local desc = {}
	desc[#desc+1] = "You must navigate the sewers to find a way out."
	return table.concat(desc, "\n")
end
