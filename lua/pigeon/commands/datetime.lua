local datetime = require("pigeon.config").options.datetime
local command = vim.api.nvim_create_user_command

command("PigeonToggleDatetime", function()
	datetime.enabled = not datetime.enabled
end, {})


