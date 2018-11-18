
newEntity{
    define_as = "SIGN",
    type = "floor", subtype = "sign",
    name = "sign",
    image = "terrain/sign.png",
    display = '.', color=colors.DARK_GREY, back_color=colors.BLACK,
    does_block_move = false,
    block_sight = false,
    on_move = function(self, x, y, who)
        game.player:showForeignPopup("Test", "This is a test", "Exo Eirhavir")
    end,
}

