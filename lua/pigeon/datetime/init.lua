local datetime = require("pigeon.config").options.datetime
local pigeon_feeding = require("pigeon.config").enabled
local M = {}

M.current_day = function()
	return datetime.day.icon .. os.date(datetime.day.format)
end

M.current_time = function()
	return datetime.time.icon .. os.date(datetime.time.format) .. datetime.time.posttext
end

M.current_date = function()
	return datetime.date.icon .. os.date(datetime.date.format)
end

if pigeon_feeding then
	return M
end
