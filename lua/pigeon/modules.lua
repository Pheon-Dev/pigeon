local config = require("pigeon.config")

local M = {}

function M.init()
	if config.battery.enabled then
		require("pigeon.battery").init()
	end
end

return M
