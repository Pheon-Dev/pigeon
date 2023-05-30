local datetime = require("pigeon.config").options.datetime
local command = vim.api.nvim_create_user_command

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

command("PigeonToggleDatetime", function()
	datetime.enabled = not datetime.enabled
end, {})

if datetime.enabled then
	return M
else
	print("󱗆 pigeon date and time module is disabled")
end
