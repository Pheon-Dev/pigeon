local config = require("pigeon.config")
local callback = require("pigeon.utils.data").do_callback
local pigeon_feeding

local M = {}

function M.respawn()
	callback("respawning_pigeon")
	pigeon_feeding = true
	require("pigeon.config").options.enabled = pigeon_feeding
end

function M.kill()
	vim.api.nvim_create_augroup("KillPigeon", { clear = true })
	callback("killing_pigeon")
	pigeon_feeding = false
	require("pigeon.config").options.enabled = pigeon_feeding
end

function M.toggle()
	if pigeon_feeding then
		M.kill()
		print("󱗆 pigeon killed")
	else
		M.respawn()
		print("󱗆 pigeon respawned")
	end
end

M.setup = function(opts)
	vim.validate({ opts = { opts, "table", true } })
	config.load(opts)
end

if pigeon_feeding then
	return M
else
	print("pigeon not feeding")
end
