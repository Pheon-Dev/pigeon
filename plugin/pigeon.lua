if vim.g.loaded_pigeon then
	return
end

vim.g.loaded_pigeon = true
local battery = require("pigeon.config").options.battery
local datetime = require("pigeon.config").options.datetime
local internet = require("pigeon.config").options.internet
local command = vim.api.nvim_create_user_command

command("PigeonToggle", function()
	require("pigeon").toggle()
end, {})

command("PigeonToggleInternet", function()
	internet.enabled = not internet.enabled
end, {})

command("PigeonToggleDatetime", function()
	datetime.enabled = not datetime.enabled
end, {})

command("PigeonToggleBattery", function()
	battery.enabled = not battery.enabled
end, {})
