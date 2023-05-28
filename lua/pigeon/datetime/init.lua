local config = require("pigeon.config")

local M = {}

M.day = function()
	return os.date(" %A")
end

M.time = function()
	return os.date(" %H:%M")
end

M.date = function()
	return os.date(" %Y-%m-%d")
end

return M
