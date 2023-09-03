local volume = require("pigeon.config").options.volume
local command = vim.api.nvim_create_user_command

local M = {}

function M.volume_commands()
	command("PigeonToggleVolume", function()
		volume.enabled = not volume.enabled
		if volume.enabled then
			print("󱗆 pigeon volume module is enabled")
		end
		if not volume.enabled then
			print("󱗆 pigeon volume module is disabled")
		end
	end, {})
end

return M
