local internet = require("pigeon.config").options.internet

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
	local unit = internet.signal.unit

	local function fetch_signal_speed()
		local signal = vim.fn.systemlist('iwconfig 2>&1 | grep -o "Bit Rate=.*" | grep -o "[0-9.]*"')
		result = tonumber(signal[1]) .. " " .. unit
	end

	fetch_signal_speed()

	return result
end

return M
