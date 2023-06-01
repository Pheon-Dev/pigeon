local battery = require("pigeon.config").options.battery
local command = vim.api.nvim_create_user_command

local M = {}

function M.battery_commands()
	command("PigeonToggleBattery", function()
		battery.enabled = not battery.enabled
		if battery.enabled then
			print("󱗆 pigeon battery module is enabled")
		end
		if not battery.enabled then
			print("󱗆 pigeon battery module is disabled")
		end
	end, {})

	if not battery.enabled then
		print("󱗆 pigeon battery module is disabled")
	end
end

return M
