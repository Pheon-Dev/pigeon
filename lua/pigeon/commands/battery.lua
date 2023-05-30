local battery = require("pigeon.config").options.battery
local command = vim.api.nvim_create_user_command

command("PigeonToggleBattery", function()
	battery.enabled = not battery.enabled
end, {})

