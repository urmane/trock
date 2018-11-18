
startx = 9
starty = 9
endx = 31
endy = 16

defineTile(".", "FLOOR")
defineTile("~", "DEEP_WATER")
defineTile("#", "WALL")
defineTile("=", "WALL_ROCK")
defineTile("+", "DOOR_LOCKED_FALSE")
defineTile("C", "CROWD")
defineTile("G", "GUARD")
defineTile(">", "TO_UNDERGROUND")
--defineTile(">", "DOWN")

return [[################################
#.....CCCCCCCCCCCCCC..CCCC.....#
#.........CCC..CCCCCC...CCCC...#
#....CC..C.....CC..............#
#...C..CCC...CC..CCCCC.C.C.....#
#.C.CCCCCC..........C.....C..C.#
#.C.CC####################C.C..#
#.C.CC#GGGGG..G..G...G...#CC.CC#
#.C.CC#G#++#############.#.C.CC#
#CC.CC#G#..............#.#...CC#
#CCCCC#G#..............#G#CCCCC#
#CC..C#.#..............#.#...CC#
#CC.CC#G#..............#G#C..CC#
#CC...#.#..............#.#CC.CC#
#CC.C.#.#..............#.#.C.CC#
#CC...#.#..............#.#CC.CC#
#CC.C.#.#..............#.#.C.CC#
#CC...#G#.....~~~~.....#G#CC.CC#
#CC.C.#.#.....~~~~.....#.#C.CCC#
#CC..C#.#.....~~~~.....#.#C.CCC#
#CC..C#.#.....~~~~.....#.#C..CC#
#CC.CC#G#..............#G#C..CC#
#CC..C#.#..............#.#CC.CC#
#CC.CC#.#..............#.#CCCCC#
#CCCCC#G#..............#G#CCCCC#
#CCCCC#.#..............#.#CCCCC#
#CCCCC#.#..............#.#CCCCC#
#CCCCC#.#..............#.#CCCCC#
#CCCCC#.#..............#.#CCCCC#
#CCCCC#G#..............#G#CCCCC#
===============...==============
================>===============]]
