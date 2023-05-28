local config = require("pigeon.config")

local M = {}

M.current_day = function()
	return os.date(" %A")
end

M.current_time = function()
	return os.date(" %H:%M")
end

M.current_date = function()
	return os.date(" %Y-%m-%d")
end

return M
