load("/data/general/traps/store.lua")

newEntity{
	base = "BASE_STORE",
	define_as = "FENSTER_FENCE",
	name="Fenster's Pawn Shop",
	display='1', color=colors.LIGHT_RED,
	resolvers.store("FENCE", "neutral", "terrain/shop_door.png", "terrain/shop_sign.png"),
}
