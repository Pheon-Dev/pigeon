local internet = require("pigeon.config").options.internet
local pigeon_feeding = require("pigeon.config").options.enabled

local M = {}

M.wifi_status = function()
	local result = vim.fn.system('ping -c 1 8.8.8.8 > /dev/null 2>&1 && echo "true" || echo "false"')
	result = result:gsub("\n", "")
	result = tostring(result)
	if result == "false" then
		return internet.wifi.icons.disconnected
	else
		return internet.wifi.icons.connected
	end
end

M.signal_speed = function()
	local result = ""
	local speed = 0
	local unit = internet.signal.unit

	local function fetch_signal_speed()
		local signal = vim.fn.systemlist('iwconfig 2>&1 | grep -o "Bit Rate=.*" | grep -o "[0-9.]*"')
		if signal and #signal > 0 then
			if
				unit == "Mbps"
				or unit == "MB/s"
				or unit == "MBps"
				or unit == "mbps"
				or unit == "mb/s"
				or unit == "Mb/s"
			then
				speed = math.floor(tonumber(signal[1]) / 1000)
			end
			if unit == "dBm" or unit == "dbm" then
				speed = math.floor(tonumber(signal[1]) / 1)
			end
			result = speed .. " " .. unit
		else
			result = "󰪎"
		end
	end

	fetch_signal_speed()

	return result
end

if pigeon_feeding then
	return M
end
