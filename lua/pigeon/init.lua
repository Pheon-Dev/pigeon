local config = require("pigeon.config")

local M = {}

M.setup = config.setup

M.battery_capacity = require("pigeon.battery").battery_capacity()
M.battery_charge = require("pigeon.battery").battery_charge()
M.wifi_status = require("pigeon.internet").wifi_status()
M.signal_speed = require("pigeon.internet").signal_speed()
M.current_date = require("pigeon.datetime").current_date()
M.current_day = require("pigeon.datetime").current_day()
M.current_time = require("pigeon.datetime").current_time()

return M
