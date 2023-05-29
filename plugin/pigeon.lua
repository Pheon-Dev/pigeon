if vim.g.loaded_pigeon then
	return
end

vim.g.loaded_pigeon = true

local command = vim.api.nvim_create_user_command
local config = require("pigeon.config")

command("PigeonToggle", function()
	require("pigeon").toggle()
end, {})

if config.options.enabled then
	require("pigeon").respawn()
end
