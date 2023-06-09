local ram = require("pigeon.config").options.ram
local command = vim.api.nvim_create_user_command
local M = {}

function M.ram_commands()
	command("PigeonToggleRam", function()
		ram.enabled = not ram.enabled
		if ram.enabled then
			print("󱗆 pigeon ram module is enabled")
		end
		if not ram.enabled then
			print("󱗆 pigeon ram module is disabled")
		end
	end, {})

	command("PigeonToggleRamPercentage", function()
		ram.show_percentage = not ram.show_percentage
		if ram.show_percentage then
			print("󱗆 pigeon ram percentage is enabled")
		end
		if not ram.show_percentage then
			print("󱗆 pigeon ram percentage is disabled")
		end
	end, {})

	-- if not ram.enabled then
	-- 	print("󱗆 pigeon ram module is disabled")
	-- end
end

return M
