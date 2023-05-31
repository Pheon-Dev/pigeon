local datetime = require("pigeon.config").options.datetime
local date = require("pigeon.config").options.datetime.date
local time = require("pigeon.config").options.datetime.time
local day = require("pigeon.config").options.datetime.day
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

command("PigeonToggleTime", function()
	time.enabled = not time.enabled
	if time.enabled then
		print("󱗆 pigeon time submodule is enabled")
	end
	if not time.enabled then
		print("󱗆 pigeon time submodule is disabled")
	end
end, {})

command("PigeonToggleDay", function()
	day.enabled = not day.enabled
	if day.enabled then
		print("󱗆 pigeon day submodule is enabled")
	end
	if not day.enabled then
		print("󱗆 pigeon day submodule is disabled")
	end
end, {})

command("PigeonToggleDate", function()
	date.enabled = not date.enabled
	if date.enabled then
		print("󱗆 pigeon date submodule is enabled")
	end
	if not date.enabled then
		print("󱗆 pigeon date submodule is disabled")
	end
end, {})

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
