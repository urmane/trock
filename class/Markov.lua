
require "engine.class"

module(..., package.seeall, class.make)

function _M:init()
	self.chain = {}
end

function _M:loadChain(filename, weighted)
	local data = dofile(filename)
	if weighted then
		self.weighted = true
	else
		self.weighted = false
		self.chain = data
	end
end

-- m is the markov structure
-- p is the previous string
-- returns next string
function _M:getNextString(p)
	if not self.chain[p] then return "" end
	local rnd = rng.range(1, table.getn(self.chain[p])) -- equal weighting
	return self.chain[p][rnd]
end

-- m is the markov structure
-- start is the starting string, default is to randomly select one
-- min is the minimum length to generate, default is 4
-- max is the maximum length to generate, default is 12
function _M:generateWord(start, min, max)
	if not self.chain then return end

	local startString = ""
	local word = {}
	if not start or not self.chain[start] then
		if not self.chain["start"] then return end
		rnd = rng.range(1, table.getn(self.chain["start"]))
		startString = self.chain["start"][rnd]
	else
		startString = start
	end
	table.insert(word, startString)

	local wordlen = 0
	if max then wordlen = rng.range(min, max) else wordlen = 12 end

	local len = string.len(startString) -- already added startString
	local prevString = startString
	while len <= wordlen do
		nextString = self:getNextString(prevString)
		if not nextString then break end
		table.insert(word, nextString)
		prevString = nextString
		len = len + string.len(prevString)
	end

	return table.concat(word)
end

