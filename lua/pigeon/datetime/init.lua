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

command("PigeonToggleDateTime", function()
	datetime.enabled = not datetime.enabled
if datetime.enabled then
	print("󱗆 pigeon date and time module is enabled")
end
if not datetime.enabled then
	print("󱗆 pigeon date and time module is disabled")
end
end, {})

if not datetime.enabled then
	print("󱗆 pigeon date and time module is disabled")
end

return M
