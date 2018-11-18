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

base_size = 32

return { generator = function()
	local ad = rng.range(240, 300)
	local a = math.rad(ad)
	local dir = math.rad(ad + 90)
	local r = rng.range(3, 20)

	return {
		trail = 0,
		life = 60,
		size = 4, sizev = -0.05, sizea = -0.05,

		x = r * math.cos(a), xv = 0, xa = 0,
		y = r * math.sin(a), yv = 0, ya = 0,
		dir = dir, dirv = 1, dira = 0,
		vel = 1, velv = 0, vela = 0,

		r = 0,   rv = 0, ra = 0,
		g = 0,   gv = 0.1, ga = 0,
		b = 0.9, bv = 0, ba = 0,
		a = 1,   av = -0.04, aa = 0,
	}
end, },
function(self)
	self.ps:emit(6)
end,
360, nil, false
