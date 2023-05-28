local config = require("pigeon.config")

local M = {}

M.setup = config.setup

M.battery = require("pigeon.battery").init()

return M
