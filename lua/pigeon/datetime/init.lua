local datetime = require("pigeon.config").options.datetime
local config = require("pigeon.config")

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

if config.options.enabled then
	return M
else
	print("󱗆 pigeon datetime module disabled")
end
