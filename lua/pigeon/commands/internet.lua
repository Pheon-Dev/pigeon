local internet = require("pigeon.config").options.internet
local command = vim.api.nvim_create_user_command

command("PigeonToggleInternet", function()
	internet.enabled = not internet.enabled
end, {})
