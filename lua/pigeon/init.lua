local config = require("pigeon.config")
local status = require("pigeon.config").options.enabled
local callback = require("pigeon.utils.data").do_callback
local pigeon_feeding

local M = {}

function M.respawn()
	callback("respawning_pigeon")
	pigeon_feeding = true
end

function M.kill()
	vim.api.nvim_create_augroup("KillPigeon", { clear = true })
	callback("killing_pigeon")
	pigeon_feeding = false
end

function M.toggle()
	if pigeon_feeding then
		M.kill()
		print("󱗆 pigeon killed: " .. status)
	else
		M.respawn()
		print("󱗆 pigeon respawned: " .. status)
	end
end

M.setup = function(opts)
	vim.validate({ opts = { opts, "table", true } })
	config.load(opts)
end

return M
