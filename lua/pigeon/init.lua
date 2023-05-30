local config = require("pigeon.config")

local M = {}

M.setup = function(opts)
	vim.validate({ opts = { opts, "table", true } })
	config.load(opts)
end

return M
