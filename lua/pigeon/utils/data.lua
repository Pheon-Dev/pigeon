local M = {}

local config = require("pigeon.config")

function M.do_callback(callback_name)
	if type(config.options.callbacks[callback_name]) == "function" then
		config.options.callbacks[callback_name]()
	end
end

return M
