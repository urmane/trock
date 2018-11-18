
startx = 1
starty = 13
endx = 1
endy = 13

defineTile("<", "UP")
defineTile(".", "GRASS")
defineTile("~", "WATER")
defineTile("#", "WALL")
defineTile("%", "FIRE")
defineTile("&", "AIR")
defineTile("^", "GRAVESTONE")
defineTile("|", "TREE")
defineTile(">", "DOWN")
defineTile("N", "GRASS", nil, "NATURE")

return [[
|||||||||||||||
||||%%%.%%%||||
|||..%%.%%..|||
||....%.%....||
|#...........&|
|##.........&&|
|###.......&&&|
|......N......|
|###.......&&&|
|##.........&&|
|#...........&|
||....~.~....||
||...~~.~~..|||
|<||~~~.~~~||||
|||||||||||||||]]
