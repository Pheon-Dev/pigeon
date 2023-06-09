local internet = require("pigeon.config").options.internet
local command = vim.api.nvim_create_user_command
local M = {}

function M.internet_commands()
	command("PigeonToggleInternet", function()
		internet.enabled = not internet.enabled
		if internet.enabled then
			print("󱗆 pigeon internet module is enabled")
		end
		if not internet.enabled then
			print("󱗆 pigeon internet module is disabled")
		end
	end, {})

	-- if not internet.enabled then
	-- 	print("󱗆 pigeon internet module is disabled")
	-- end
end

return M
