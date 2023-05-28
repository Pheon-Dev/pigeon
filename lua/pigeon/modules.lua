local config = require("pigeon.config")

local M = {}

function M.init()
	require("pigeon.battery").init()
end

return M
