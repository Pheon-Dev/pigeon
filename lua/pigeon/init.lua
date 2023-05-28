local config = require("pigeon.config")

local M = {}

M.setup = config.setup

M.battery = require("pigeon.battery").capacity()
M.battery = require("pigeon.battery").charge()
M.wifi = require("pigeon.internet").wifi()
M.signal = require("pigeon.internet").signal()
M.date = require("pigeon.datetime").date()
M.day = require("pigeon.datetime").day()
M.time = require("pigeon.datetime").time()

return M
