
-- Treasure - items whose only purpose is to be sold for coin
-- Probably won't include gems, as those may be used for else?

-- quality to value multiplier
local quality = {
	{"roughly-made", 1},
	{"amateurish", 3},
	{"mediocre", 6},
	{"average", 10},
	{"fine", 20},
	{"excellent", 50},
	{"masterpiece", 200},
	{"legendary", 2000},
	}

-- size to encumbrance multiplier
local size = {
	{"tiny", 1},
	{"small", 5},
	{"medium", 10},
	{"large", 100},
	{"enormous", 1000},
	}

newEntity{
	define_as = "BASE_TREASURE",
	type = "treasure", --subtype="copper",
	display = "*", color=colors.YELLOW,
	encumber = 0,
	use_no_wear = true, identified = true, stacking = true,
	auto_pickup = true, pickup_sound = "actions/coin",
	desc = [[Something valuable to sell.]],
}

local function newTreasure(name, image, subtype, rarity, min_level, max_level, basecost, enc)
	newEntity{
		base = "BASE_TREASURE",
		define_as = name:gsub(" ", "_"):upper(),
		name = name:lower(),
		image = image, subtype = subtype, rarity = rarity,
		level_range = {min_level, max_level},
		cost = basecost,
		encumber = enc,
		--on_prepickup = function(self, who, id)
			--local count = rng.range(min_count, max_count)
			--game.logPlayer(who, "Counting %d %s", count, self.name)
			---- Ponder - liquid vs networth?  ;-)
			---- actual coin incs max and current, jewelry incs max only?
			---- liquid used for bribes ...
        		--game.player.incMaxGold(game.player, cost * count)
        		--game.player.incGold(game.player, cost * count)
			--game.logPlayer(who, "Added %0.2f gold", cost * count)
        		--game.level.map:removeObject(who.x, who.y, id)
        		--return true
		--end
	}
end

newTreasure("a few coins", "treasure/few-coins.png", "furniture", 1, 1, 10, 100, 50)
newTreasure("many coins", "treasure/many-coins.png", "furniture", 1, 1, 10, 100, 50)
newTreasure("Persian rug",   "treasure/coins.png", "furniture", 1, 1, 10, 100, 50)
newTreasure("small painting",   "treasure/coins.png", "furniture", 1, 1, 10, 100, 5)
newTreasure("painting",   "treasure/coins.png", "furniture", 1, 1, 10, 100, 40)
newTreasure("large painting",   "treasure/coins.png", "furniture", 1, 1, 10, 100, 100)
