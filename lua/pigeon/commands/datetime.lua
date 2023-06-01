local datetime = require("pigeon.config").options.datetime
local date = datetime.date
local time = datetime.time
local day = datetime.day
local command = vim.api.nvim_create_user_command

local M = {}

function M.datetime_commands()
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
end

return M
