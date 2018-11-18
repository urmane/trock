-- ITS - In The Shadows
-- Copyright (C) 2015, 2016, 2017 James Niemira
--
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
-- James Niemira "urmane"
-- jim.niemira@gmail.com

tiles =
{
{type="tunnel", define_as="WIDE_TUNNEL",
[[##...##]],
[[##...##]],
[[##...##]],
[[##...##]],
[[##...##]],
[[##...##]],
[[##...##]],
},
{type="room", base="WIDE_TUNNEL", rotation="90"},

{type="tunnel", define_as="WIDE_TUNNEL_PILLAR",
[[##...##]],
[[##...##]],
[[##.#.##]],
[[##...##]],
[[##.#.##]],
[[##...##]],
[[##...##]],
},
{type="room", base="WIDE_TUNNEL_PILLAR", rotation="90"},


{type="tunnel", define_as="3CORRIDOR_PILLAR",
[[##...##]],
[[##...##]],
[[.....##]],
[[...#.##]],
[[.....##]],
[[##...##]],
[[##...##]],
},
{type="room", base="3CORRIDOR_PILLAR", rotation="90"},
{type="room", base="3CORRIDOR_PILLAR", rotation="180"},
{type="room", base="3CORRIDOR_PILLAR", rotation="270"},

{type="tunnel",
[[##...##]],
[[##...##]],
[[.......]],
[[.......]],
[[.......]],
[[##...##]],
[[##...##]],
},
}
