require "engine.class"

module(..., package.seeall, class.make)

seconds_per_turn = 10

MINUTE = 60 / seconds_per_turn
HOUR = MINUTE * 60
HOURS_PER_DAY = 24
DAY_START = HOUR * 6
DAY = HOUR * HOURS_PER_DAY
DAYS_PER_YEAR = 360
YEAR = DAY * DAYS_PER_YEAR

MOON1_CYCLE = 30
MOON2_CYCLE = 90
MOON3_CYCLE = 75

--- Create a calendar
-- @param definition the file to load that returns a table containing calendar months
-- @param datestring a string to format the date when requested, in the format "%s %s %s %d %d", standing for, day, month, year, hour, minute
function _M:init(definition, datestring, start_year, start_day, start_hour)
	local data = dofile(definition)
	self.calendar = {}
	local days = 0
	for _, e in ipairs(data) do
		if not e[3] then e[3] = 0 end
		table.insert(self.calendar, { days=days, name=e[2], length=e[1], offset=e[3] })
		days = days + e[1]
	end
	assert(days == DAYS_PER_YEAR, "Calendar incomplete, days ends at "..days.." instead of "..DAYS_PER_YEAR)

	self.datestring = datestring
	self.start_year = start_year
	self.start_day = start_day or 1
	self.start_hour = start_hour or 8
end

function _M:getTimeDate(turn, dstr)
	local doy, year = self:getDayOfYear(turn)
	local hour, min = self:getTimeOfDay(turn)
	return (dstr or self.datestring):format(tostring(self:getDayOfMonth(doy)):ordinal(), self:getMonthName(doy), tostring(year):ordinal(), hour, min)
end

function _M:getDayOfYear(turn)
	local d, y
	turn = turn + self.start_hour * self.HOUR
	d = math.floor(turn / self.DAY) + (self.start_day - 1)
	y = math.floor(d / DAYS_PER_YEAR)
	d = math.floor(d % DAYS_PER_YEAR)
	return d, self.start_year + y
end

function _M:getTimeOfDay(turn)
	local hour, min
	turn = turn + self.start_hour * self.HOUR
	min = math.floor((turn % self.DAY) / self.MINUTE)
	hour = math.floor(min / 60)
	min = math.floor(min % 60)
	return hour, min
end

function _M:getMonthNum(dayofyear)
	local i = #self.calendar

	-- Find the period name
	while ((i > 1) and (dayofyear < self.calendar[i].days)) do
		i = i - 1
	end

	return i
end

function _M:getMonthName(dayofyear)
	local month = self:getMonthNum(dayofyear)
	return self.calendar[month].name
end

function _M:getDayOfMonth(dayofyear)
	local month = self:getMonthNum(dayofyear)
	return dayofyear - self.calendar[month].days + 1 + self.calendar[month].offset
end

function _M:getMonthLength(dayofyear)
	local month = self:getMonthNum(dayofyear)
	return self.calendar[month].length
end
