if vim.g.loaded_pigeon then
	return
end

vim.g.loaded_pigeon = true

local command = vim.api.nvim_create_user_command

command("PigeonToggle", function()
	require("pigeon").toggle()
end, {})
