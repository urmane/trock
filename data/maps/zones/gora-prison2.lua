
startx = 59
starty = 47
endx = 3
endy = 7

defineTile(".", "FLOOR")
defineTile("~", "DEEP_WATER")
defineTile("#", "WALL")
defineTile("'", "CELL_DOOR_OPEN")
defineTile("+", "CELL_DOOR_LOCKED")
defineTile(">", "DOWN")
defineTile("<", "UP")
defineTile("G", "FLOOR", nil, {random_filter={name="prisonguard"}})
defineTile("t", "FLOOR", nil, {random_filter={name="torch"}})
defineTile("b", "FLOOR", nil, {random_filter={name="brazier"}})
defineTile("P", "FLOOR", nil, {random_filter={type="humanoid", subtype="prisoner"}})

return [[
###############################################################
#.....###################################################.....#
#.....###################################################.....#
#.....###################################################.....#
####..###################################################..####
#t.............................t.............................t#
#.............................................................#
#..>.............#...........................#.............#..#
#...............................................G.............#
#.............................................................#
#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#
#.....#.#.#.#.#.....#.#.#.#.#.....#.#.#.#.#.....#.#.#.#.#.....#
#.....#########.....#########.....#########.....#########.....#
#.....#.#.#.#.#.....#P#P#P#P#.....#.#P#P#.#.....#.#.#.#.#.....#
#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#
#.............................................................#
#.............................................................#
#..#..........G..b.............b.............b.............#..#
#.............................................................#
#.............................................................#
#.....#+#+#+#+#.................................#+#+#+#+#.....#
#.....#.#.#P#.#.................................#.#.#.#.#.....#
#.....#########.................................#########.....#
#.....#.#P#.#.#.................................#P#.#.#.#.....#
#.....#+#+#+#+#.................................#+#+#+#+#.....#
#..........................................G..................#
#.............................................................#
#t...............b.............b.............b...............t#
#.............................................................#
#.............................................................#
#.....#+#+#+#+#.................................#+#+#+#+#.....#
#.....#P#.#.#.#.................................#.#.#.#.#.....#
#.....#########.................................#########.....#
#.....#P#.#.#.#.................................#.#P#.#.#.....#
#.....#+#+#+#+#.................................#+#+#+#+#.....#
#.............................................................#
#.............................G...............................#
#..#.............b.............b.............b.............#..#
#.............................................................#
#.............................................................#
#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#
#.....#P#.#.#.#.....#.#P#P#.#.....#.#.#P#.#.....#.#P#.#P#.....#
#.....#########.....#########.....#########.....#########.....#
#.....#.#.#.#.#.....#.#.#.#.#.....#.#.#.#.#.....#.#.#.#P#.....#
#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#+#+#+#+#.....#
#.............................................................#
#.............................................................#
#..#.............#...........................#.............<..#
#.....................G.......................................#
#t.............................t.............................t#
####..###################################################..####
#.....###################################################.....#
#.....###################################################.....#
#.....###################################################.....#
###############################################################]]
