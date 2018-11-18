-- These tiles are intended to be closed rooms
tiles =
{
{type="room", define_as = "ROOM_5DOOR1",
[[##'##]],
[[#...#]],
[[#...#]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR1", rotation="90"},
{type="room", base="ROOM_5DOOR1", rotation="180"},
{type="room", base="ROOM_5DOOR1", rotation="270"},

{type="room", define_as = "ROOM_5DOOR2",
[[#'###]],
[[#...#]],
[[#...#]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR2", rotation="90"},
{type="room", base="ROOM_5DOOR2", rotation="180"},
{type="room", base="ROOM_5DOOR2", rotation="270"},

-- will this work?
{type="room", base="ROOM_5DOOR2", symmetric="x", define_as = "ROOM_5DOOR3"},
{type="room", base="ROOM_5DOOR3", rotation="90"},
{type="room", base="ROOM_5DOOR3", rotation="180"},
{type="room", base="ROOM_5DOOR3", rotation="270"},

{type="room", define_as = "ROOM_5H",
[[##.##]],
[[#...#]],
[[##.##]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5H", rotation="90"},

{type="room", define_as = "ROOM_5_4DOORS",
[[##'##]],
[[#...#]],
[['...']],
[[#...#]],
[[##'##]],
},

{type="room", define_as = "ROOM_5DOOR4",
[[#####]],
[[#...']],
[['...#]],
[[#...']],
[[#####]],
},
{type="room", base="ROOM_5DOOR4", rotation="90"},
{type="room", base="ROOM_5DOOR4", rotation="180"},
{type="room", base="ROOM_5DOOR4", rotation="270"},

{type="room", define_as = "ROOM_5DOOR6",
[[##'##]],
[[#...#]],
[[#+++#]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR6", rotation="90"},
{type="room", base="ROOM_5DOOR6", rotation="180"},
{type="room", base="ROOM_5DOOR6", rotation="270"},

{type="room", define_as = "ROOM_5DOOR5",
[[##'##]],
[[#...#]],
[[###.#]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR5", rotation="90"},
{type="room", base="ROOM_5DOOR5", rotation="180"},
{type="room", base="ROOM_5DOOR5", rotation="270"},

{type="room", define_as = "ROOM_5DOOR7",
[[##'##]],
[[#...#]],
[['...#]],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR7", rotation="90"},
{type="room", base="ROOM_5DOOR7", rotation="180"},
{type="room", base="ROOM_5DOOR7", rotation="270"},

{type="room", define_as = "ROOM_5DOOR8",
[[##'##]],
[[#...#]],
[['...']],
[[#...#]],
[[#####]],
},
{type="room", base="ROOM_5DOOR8", rotation="90"},
{type="room", base="ROOM_5DOOR8", rotation="180"},
{type="room", base="ROOM_5DOOR8", rotation="270"},

{type="room", define_as = "ROOM_5DOOR9",
[[##'##]],
[[#...#]],
[[#####]],
[[#####]],
[[#####]],
},
{type="room", base="ROOM_5DOOR9", rotation="90"},
{type="room", base="ROOM_5DOOR9", rotation="180"},
{type="room", base="ROOM_5DOOR9", rotation="270"},

}