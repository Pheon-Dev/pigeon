local internet = require("pigeon.config").options.internet

local M = {}

M.wifi_status = function()
	local wifi_state = vim.fn.systemlist('iwconfig 2>&1 | grep -o "ESSID:.*" | grep -o "[Aa0-Zz9.]*"')
	wifi_state = tostring(wifi_state[2])
	local result

	if wifi_state == "off" then
		result = internet.wifi.icons.disconnected
	else
		result = internet.wifi.icons.connected
	end

	return result
end

M.wifi_essid = function()
	local wifi_state = vim.fn.systemlist('iwconfig 2>&1 | grep -o "ESSID:.*" | grep -o "[Aa0-Zz9.]*"')
	wifi_state = tostring(wifi_state[2])
	return wifi_state
end

M.bit_rate = function()
	local result = ""
	local unit = internet.signal.unit

	local function fetch_signal_speed()
		local signal = vim.fn.systemlist('iwconfig 2>&1 | grep -o "Bit Rate=.*" | grep -o "[0-9.]*"')
		if signal and #signal > 0 then
			result = tonumber(signal[1]) .. " " .. unit
		else
			result = " 󰪎"
		end
	end

	fetch_signal_speed()

	return result
end

require("pigeon.commands.internet").internet_commands()

return M
