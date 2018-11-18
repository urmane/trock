
newEntity{
    define_as = "GRAVESTONE",
    type = "wall", subtype = "gravestone",
    name = "a gravestone",
    image = "terrain/graveyard/gravestone.png", --add_mos={{image="terrain/troll_stew.png"}},
    display = '^', color=colors.LIGHT_RED, back_color=colors.RED,
    does_block_move = true,
	block_sight = true,
    on_block_bump = function(e)
        -- actor is always player, yes?
        if not e.epitaph then
            local name = game.markov["english"]:generateWord("T", 5, 12)
            e.epitaph = rng.table{
            string.format("Here lies %s", name),
            }
        end
        game.log(e.epitaph)
    end,
}

newEntity{
    define_as = "FRESH_GRAVE",
    type = "floor", subtype = "freshgrave",
    name = "a fresh grave",
    image = "terrain/graveyard/freshgrave.png", --add_mos={{image="terrain/troll_stew.png"}},
    display = '.', color=colors.LIGHT_RED, back_color=colors.RED,
    does_block_move = false,
	block_sight = false,
}

